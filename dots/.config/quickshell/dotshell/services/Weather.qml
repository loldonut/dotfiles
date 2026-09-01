pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

import qs.modules.config

// from https://github.com/end-4/dots-hyprland

Singleton {
  id: root

  readonly property bool useUSCS: Config.bar.useUSCS

  onUseUSCSChanged: {
    root.getData();
  }

  property var data: ({
      cloudcover: 0,
      desc: "",
      humidity: 0,
      observationTime: "",
      pressure: 0,
      temp: 0,
      uvIndex: 0,
      windspeedKmph: 0
    })

  function formatData(data) {
    let weather = {};

    weather.desc = data?.current?.weatherDesc[0]?.value || "";
    weather.humidity = data?.current?.humidity || 0;
    weather.observationTime = data?.current?.observation_time || "";
    weather.uvIndex = data?.current?.uvIndex || 0;

    weather.temp = "";

    if (root.useUSCS) {
      weather.wind = (data?.current?.windspeedMiles || 0) + " mph";
      weather.precip = (data?.current?.precipInches || 0) + " in";
      weather.visib = (data?.current?.visibilityMiles || 0) + " m";
      weather.press = (data?.current?.pressureInches || 0) + " psi";
      weather.temp += (data?.current?.temp_F || 0);
      weather.temp += "°F";
      weather.tempFeelsLike += "°F";
    } else {
      weather.wind = (data?.current?.windspeedKmph || 0) + " km/h";
      weather.precip = (data?.current?.precipMM || 0) + " mm";
      weather.visib = (data?.current?.visibility || 0) + " km";
      weather.press = (data?.current?.pressure || 0) + " hPa";
      weather.temp += (data?.current?.temp_C || 0);
      weather.temp += "°C";
    }

    root.data = weather;
  }

  function getData() {
    wttr.running = true;
  }

  Process {
    id: wttr
    command: ["sh", "-c", `curl -L wttr.in/?format=j1 | jq '{current: .current_condition[0]}'`]
    stdout: StdioCollector {
      onStreamFinished: {
        if (this.text.length === 0)
          return;
        root.formatData(JSON.parse(this.text));
      }
    }
  }

  Timer {
    running: true
    triggeredOnStart: true
    repeat: true
    // 10 mins
    interval: 10 * 60 * 1000
    onTriggered: getData()
  }
}
