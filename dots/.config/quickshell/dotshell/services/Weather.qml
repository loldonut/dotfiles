pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// from https://github.com/end-4/dots-hyprland

Singleton {
  id: root

  property var data: ({
      cloudcover: 0,
      desc: "",
      humidity: 0,
      observationTime: "",
      pressure: 0,
      tempC: 0,
      tempF: 0,
      uvIndex: 0,
      windspeedKmph: 0
    })

  function formatData(data) {
    let weather = {};

    weather.cloudcover = data?.current?.cloudcover || 0;
    weather.desc = data?.current?.weatherDesc[0]?.value || "";
    weather.humidity = data?.current?.humidity || 0;
    weather.observationTime = data?.current?.observation_time || "";
    weather.pressure = data?.current?.pressure || 0;
    weather.tempC = data?.current?.temp_C || 0;
    weather.tempF = data?.current?.temp_F || 0;
    weather.uvIndex = data?.current?.uvIndex || 0;
    weather.windspeedKmph = data?.current?.windspeedKmph || 0;

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
