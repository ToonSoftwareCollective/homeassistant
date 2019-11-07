import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0

import FileIO 1.0

App {
    id: homeassistantApp

    property int debug : 0
 
    property url tileUrl : "HomeassistantTile.qml";
    property url thumbnailIcon: "qrc:/tsc/homeAssistant.png";

    property HomeassistantConfigurationScreen homeAssistantConfigurationScreen
    property url homeAssistantConfigurationScreenUrl : "HomeassistantConfigurationScreen.qml"

    property HomeassistantScreen homeAssistantScreen 
    property url homeAssistantScreenUrl : "HomeassistantScreen.qml"

    property string message : ""

    property int connected : 0

    property string url : ""
    property string urlPass : ""

    property string homeAssistantServer : ""
    property string homeAssistantSSL : ""
    property string homeAssistantPort : ""
    property string homeAssistantPass : ""
    property int homeAssistantLegacy
    property string homeAssistantToken : ""

    FileIO {
        id: tokenFile
        source: "file:///mnt/data/tsc/homeassistant.token.txt"
    }

    property variant homeAssistantSettingsJson : {
        'Server': "",
        'SSL': "",
        'Port': "",
        'Pass': ""
    }

    FileIO {
        id: userSettingsFile
        source: "file:///mnt/data/tsc/homeassistant.userSettings.json"
    }

    property string homeAssistantSensor1 : ""
    property string homeAssistantSensor2 : ""
    property string homeAssistantSensor3 : ""
    property string homeAssistantSensor4 : ""
    property string homeAssistantSensor5 : ""
    property string homeAssistantSensor6 : ""
    property string homeAssistantSensor7 : ""
    property string homeAssistantSensor8 : ""

    property variant homeAssistantSensorsJson : {
        'Sensor1': "",
        'Sensor2': "",
        'Sensor3': "",
        'Sensor4': "",
        'Sensor5': "",
        'Sensor6': "",
        'Sensor7': "",
        'Sensor8': "",
    }

    FileIO {
        id: sensorFile
        source: "file:///mnt/data/tsc/homeassistant.sensors.json"
    }

    property variant homeAssistantSensor1Info : []
    property variant homeAssistantSensor2Info : []
    property variant homeAssistantSensor3Info : []
    property variant homeAssistantSensor4Info : []
    property variant homeAssistantSensor5Info : []
    property variant homeAssistantSensor6Info : []
    property variant homeAssistantSensor7Info : []
    property variant homeAssistantSensor8Info : []

    property variant homeAssistantSensorInfoJson : {
        'Sensor1Info': "",
        'Sensor2Info': "",
        'Sensor3Info': "",
        'Sensor4Info': "",
        'Sensor5Info': "",
        'Sensor6Info': "",
        'Sensor7Info': "",
        'Sensor8Info': "",
    }

    property string homeAssistantScene1 : ""
    property string homeAssistantScene2 : ""
    property string homeAssistantScene3 : ""
    property string homeAssistantScene4 : ""

    property variant homeAssistantScenesJson : {
        'Scene1': "",
        'Scene2': "",
        'Scene3': "",
        'Scene4': "",
    }

    FileIO {
        id: scenesFile
        source: "file:///mnt/data/tsc/homeassistant.scenes.json"
    }

    property variant homeAssistantScene1Info : []
    property variant homeAssistantScene2Info : []
    property variant homeAssistantScene3Info : []
    property variant homeAssistantScene4Info : []

    property variant homeAssistantSceneInfoJson : {
        'Scene1Info': "",
        'Scene2Info': "",
        'Scene3Info': "",
        'Scene4Info': "",
    }

    property int sliderBtnWidth : 0
    property string homeAssistantSlider1 : ""
    property real homeAssistantSlider1Max : 0.0
    property real homeAssistantSlider1Min : 0.0
    property real homeAssistantSlider1Step : 0.0
    property int homeAssistantSlider1Options : 0
    property string imgNotSelected : "qrc:/tsc/notselected.png"
    property string imgSelected : "qrc:/tsc/selected.png"

    property variant homeAssistantSlidersJson : {
        'Slider1': "",
    }

    FileIO {
        id: slidersFile
        source: "file:///mnt/data/tsc/homeassistant.sliders.json"
    }

    property variant homeAssistantSlider1Info : []

    property variant homeAssistantSliderInfoJson : {
        'Slider1Info': "",
    }

    property string homeAssistantSwitch1 : ""
    property string homeAssistantSwitch2 : ""
    property string homeAssistantSwitch3 : ""
    property string homeAssistantSwitch4 : ""
    property string homeAssistantSwitch5 : ""

    property variant homeAssistantSwitchesJson : {
        'Switch1': "",
        'Switch2': "",
        'Switch3': "",
        'Switch4': "",
        'Switch5': "",
    }

    FileIO {
        id: switchFile
        source: "file:///mnt/data/tsc/homeassistant.switches.json"
    }

    property variant homeAssistantSwitch1Info : []
    property variant homeAssistantSwitch2Info : []
    property variant homeAssistantSwitch3Info : []
    property variant homeAssistantSwitch4Info : []
    property variant homeAssistantSwitch5Info : []

    property variant homeAssistantSwitchInfoJson : {
        'Switch1Info': "",
        'Switch2Info': "",
        'Switch3Info': "",
        'Switch4Info': "",
        'Switch5Info': "",
    }

    property string homeAssistantAlarmCodeLabel : ""
    property string homeAssistantAlarmCode : ""
    property string homeAssistantAlarmState : ""
    property string homeAssistantAlarm1 : ""
    property string homeAssistantAlarm2 : ""

    property variant homeAssistantAlarmJson : {
        'Alarm1': "",
        'Code' : "",
    }

    FileIO {
        id: alarmFile
        source: "file:///mnt/data/tsc/homeassistant.alarm.json"
    }

    property string timeStr
    property string dateStr
    property int clockTile

    function updateClockInfo() {
        var now = new Date().getTime();
        timeStr = i18n.dateTime(now, i18n.time_yes);
        dateStr = i18n.dateTime(now, i18n.mon_full);
    }

    Timer {
        id: datetimeTimer
        interval: 1000
        triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: updateClockInfo()
    }

    Timer {
        id: datetimeTimer2
        interval: 60000
        triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: getSensorInfo()
    }

    function logText(log) {
        if (debug) {
            var d = new Date();
            var datetext = d.toTimeString();
            datetext = datetext.split(' ')[0];
            message = message + "\n [" + datetext + "." + d.getMilliseconds() + "] LOG: " + log;
            if (homeAssistantScreen) {
                homeAssistantScreen.logR.visible = true;
            }
        }
    }

    //Check if connection to Home Assistant can be made
    function checkConnection() {
        var http = new XMLHttpRequest();
        var checkUrl = ""

        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                if (http.status == 200) {
                    logText("Connection SUCCESS: '" + http.responseText + "'");
                    connected = 1;
                    saveHomeAssistantSettingsJson();
                } else {
                    logText("Could not establish connection. Response: '" + http.responseText + "'");
                    connected = 0;
                    saveHomeAssistantSettingsJson();
                }
            }
        }

        if (homeAssistantSSL == "yes") {
            checkUrl = "https://" + homeAssistantServer + ":" + homeAssistantPort + "/api/";
        } else {
            checkUrl = "http://" + homeAssistantServer + ":" + homeAssistantPort + "/api/";
        }

        if (!homeAssistantLegacy) {
            try {
                homeAssistantToken = tokenFile.read().trim();
                if (homeAssistantToken.length == 0) {
                    throw "Error: No token found";
                }
            }
            catch (err) {
                var doc1 = new XMLHttpRequest();
                doc1.open("PUT", "file:///mnt/data/tsc/homeassistant.token.txt");
                doc1.send('');
                logText("Please verify token.txt. " + err);
            }

            http.open("GET", checkUrl, true);
            http.setRequestHeader("Authorization", "Bearer " + homeAssistantToken);
        } else {
            checkUrl = checkUrl + "?api_password=" + encodeURIComponent(homeAssistantPass);
            http.open("GET", checkUrl, true);
        }

        http.send();
    }

    //Store Home Assistant connection settings
    function saveHomeAssistantSettingsJson() {
        var homeAssistantSettingsJson = {
            "Server" : homeAssistantServer,
            "SSL" : homeAssistantSSL,
            "Port" : homeAssistantPort,
            "Pass" : homeAssistantPass,
            "Clock" : clockTile,
            "Legacy" : homeAssistantLegacy,
        }
        var doc2 = new XMLHttpRequest();
        doc2.open("PUT", "file:///mnt/data/tsc/homeassistant.userSettings.json");
        doc2.send(JSON.stringify(homeAssistantSettingsJson));

        if (homeAssistantSSL == "yes") {
            url = "https://" + homeAssistantServer + ":" + homeAssistantPort;
        } else {
            url = "http://" + homeAssistantServer + ":" + homeAssistantPort;
        }

        if (homeAssistantPass) {
            urlPass = "?api_password=" + encodeURIComponent(homeAssistantPass);
        }

        saveHomeAssistantSensorsJson();
        saveHomeAssistantScenesJson();
        saveHomeAssistantSlidersJson();
        saveHomeAssistantSwitchesJson();
        saveHomeAssistantAlarmJson();
    }

    //Store sensor settings
    function saveHomeAssistantSensorsJson() {
        var homeAssistantSensorsJson = {
            "Sensor1" : homeAssistantSensor1,
            "Sensor2" : homeAssistantSensor2,
            "Sensor3" : homeAssistantSensor3,
            "Sensor4" : homeAssistantSensor4,
            "Sensor5" : homeAssistantSensor5,
            "Sensor6" : homeAssistantSensor6,
            "Sensor7" : homeAssistantSensor7,
            "Sensor8" : homeAssistantSensor8,
        }
        var doc3 = new XMLHttpRequest();
        doc3.open("PUT", "file:///mnt/data/tsc/homeassistant.sensors.json");
        doc3.send(JSON.stringify(homeAssistantSensorsJson));
        
        getSensorInfo();
    }

    //Retrieve sensor information from Home Assistant
    function getSensorInfo() {
        if (connected) {
            if (homeAssistantSensor1) {
                getHomeAssistant(homeAssistantSensor1, function(data) {
                    homeAssistantSensor1Info = data;
                });
            }

            if (homeAssistantSensor2) {
                getHomeAssistant(homeAssistantSensor2, function(data) {
                    homeAssistantSensor2Info = data;
                });
            }

            if (homeAssistantSensor3) {
                getHomeAssistant(homeAssistantSensor3, function(data) {
                    homeAssistantSensor3Info = data;
                });
            }

            if (homeAssistantSensor4) {
                getHomeAssistant(homeAssistantSensor4, function(data) {
                    homeAssistantSensor4Info = data;
                });
            }

            if (homeAssistantSensor5) {
                getHomeAssistant(homeAssistantSensor5, function(data) {
                    homeAssistantSensor5Info = data;
                });
            }

            if (homeAssistantSensor6) {
                getHomeAssistant(homeAssistantSensor6, function(data) {
                    homeAssistantSensor6Info = data;
                });
            }

            if (homeAssistantSensor7) {
                getHomeAssistant(homeAssistantSensor7, function(data) {
                    homeAssistantSensor7Info = data;
                });
            }

            if (homeAssistantSensor8) {
                getHomeAssistant(homeAssistantSensor8, function(data) {
                    homeAssistantSensor8Info = data;
                });
            }
        }
    }

    //Store scene settings
    function saveHomeAssistantScenesJson() {
        var homeAssistantScenesJson = {
            "Scene1" : homeAssistantScene1,
            "Scene2" : homeAssistantScene2,
            "Scene3" : homeAssistantScene3,
            "Scene4" : homeAssistantScene4,
        }
        var doc4 = new XMLHttpRequest();
        doc4.open("PUT", "file:///mnt/data/tsc/homeassistant.scenes.json");
        doc4.send(JSON.stringify(homeAssistantScenesJson));

        getSceneInfo();
    }

    function getSceneInfo() {
        if (connected) {
            getHomeAssistant(homeAssistantScene1, function(data) {
                homeAssistantScene1Info = data;
            });

            getHomeAssistant(homeAssistantScene2, function(data) {
                homeAssistantScene2Info = data;
            });

            getHomeAssistant(homeAssistantScene3, function(data) {
                homeAssistantScene3Info = data;
            });

            getHomeAssistant(homeAssistantScene4, function(data) {
                homeAssistantScene4Info = data;
            });
        }
    }

    //Store slider settings
    function saveHomeAssistantSlidersJson() {
        var homeAssistantSlidersJson = {
            "Slider1" : homeAssistantSlider1,
        }
        var doc5 = new XMLHttpRequest();
        doc5.open("PUT", "file:///mnt/data/tsc/homeassistant.sliders.json");
        doc5.send(JSON.stringify(homeAssistantSlidersJson));

        getSliderInfo();
    }

    function getSliderInfo() {
        if (connected) {
            getHomeAssistant(homeAssistantSlider1, function(data) {
                if (data) {
                    homeAssistantSlider1Info = data;
                    buildSliderObject();
                }
            });
        }
    }

    function buildSliderObject() {
        homeAssistantSlider1Max = (JSON.parse(homeAssistantSlider1Info)['attributes']['max']).toFixed(1);
        homeAssistantSlider1Min = (JSON.parse(homeAssistantSlider1Info)['attributes']['min']).toFixed(1);
        homeAssistantSlider1Step = (JSON.parse(homeAssistantSlider1Info)['attributes']['step']).toFixed(1);

        homeAssistantSlider1Options = Math.round(((homeAssistantSlider1Max - homeAssistantSlider1Min) / homeAssistantSlider1Step) + 1);

        if (homeAssistantSlider1Options > 0) {
            sliderBtnWidth = Math.round(245 / homeAssistantSlider1Options);
        }

        setSliderObject();
    }

    function setSliderObject() {
        if (connected) {
            getHomeAssistant(homeAssistantSlider1, function(data) {
                homeAssistantSlider1Info = data;
                var x = JSON.parse(homeAssistantSlider1Info)['state'];

                if (x == homeAssistantSlider1Min) {
                    homeAssistantScreen.sliderA.sliderR.sliderR1.state = "on";
                } else {
                    homeAssistantScreen.sliderA.sliderR.sliderR1.state = "off";
                }

                if (x == (homeAssistantSlider1Min + homeAssistantSlider1Step)) {
                    homeAssistantScreen.sliderA.sliderR.sliderR2.state = "on";
                } else {
                    homeAssistantScreen.sliderA.sliderR.sliderR2.state = "off";
                }

                if (x == (homeAssistantSlider1Min + (homeAssistantSlider1Step * 2))) {
                    homeAssistantScreen.sliderA.sliderR.sliderR3.state = "on";
                } else {
                    homeAssistantScreen.sliderA.sliderR.sliderR3.state = "off";
                }

                if (x == (homeAssistantSlider1Min + (homeAssistantSlider1Step * 3))) {
                    homeAssistantScreen.sliderA.sliderR.sliderR4.state = "on";
                } else {
                    homeAssistantScreen.sliderA.sliderR.sliderR4.state = "off";
                }

                if (x == (homeAssistantSlider1Min + (homeAssistantSlider1Step * 4))) {
                    homeAssistantScreen.sliderA.sliderR.sliderR5.state = "on";
                } else {
                    homeAssistantScreen.sliderA.sliderR.sliderR5.state = "off";
                }

                if (x == (homeAssistantSlider1Min + (homeAssistantSlider1Step * 5))) {
                    homeAssistantScreen.sliderA.sliderR.sliderR6.state = "on";
                } else {
                    homeAssistantScreen.sliderA.sliderR.sliderR6.state = "off";
                }
            });
        }
    }

    //Store switch settings
    function saveHomeAssistantSwitchesJson() {
        var homeAssistantSwitchesJson = {
            "Switch1" : homeAssistantSwitch1,
            "Switch2" : homeAssistantSwitch2,
            "Switch3" : homeAssistantSwitch3,
            "Switch4" : homeAssistantSwitch4,
            "Switch5" : homeAssistantSwitch5,
        }
        var doc6 = new XMLHttpRequest();
        doc6.open("PUT", "file:///mnt/data/tsc/homeassistant.switches.json");
        doc6.send(JSON.stringify(homeAssistantSwitchesJson));

        getSwitchInfo();
    }

    //Retrieve switch information from Home Assistant
    function getSwitchInfo() {
        if (connected) {
            getHomeAssistant(homeAssistantSwitch1, function(data) {
                if (data) {
                    homeAssistantSwitch1Info = data;
                    homeAssistantScreen.switch1R.switch1.state = JSON.parse(homeAssistantSwitch1Info)['state'];
                } else {
                    homeAssistantSwitch1Info = "";
                }
            });

            getHomeAssistant(homeAssistantSwitch2, function(data) {
                if (data) {
                    homeAssistantSwitch2Info = data;
                    homeAssistantScreen.switch2R.switch2.state = JSON.parse(homeAssistantSwitch2Info)['state'];
                } else {
                    homeAssistantSwitch2Info = "";
                }
                
            });

            getHomeAssistant(homeAssistantSwitch3, function(data) {
                if (data) {
                    homeAssistantSwitch3Info = data;
                    homeAssistantScreen.switch3R.switch3.state = JSON.parse(homeAssistantSwitch3Info)['state'];
                } else {
                    homeAssistantSwitch3Info = "";
                }
            });

            getHomeAssistant(homeAssistantSwitch4, function(data) {
                if (data) {
                    homeAssistantSwitch4Info = data;
                    homeAssistantScreen.switch4R.switch4.state = JSON.parse(homeAssistantSwitch4Info)['state'];
                } else {
                    homeAssistantSwitch4Info = "";
                }
            });

            getHomeAssistant(homeAssistantSwitch5, function(data) {
                if (data) {
                    homeAssistantSwitch5Info = data;
                    homeAssistantScreen.switch5R.switch5.state = JSON.parse(homeAssistantSwitch5Info)['state'];
                } else {
                    homeAssistantSwitch5Info = "";
                }
            });
        }
    }

    //Store alarm settings
    function saveHomeAssistantAlarmJson() {
        var homeAssistantAlarmJson = {
            "Alarm1" : homeAssistantAlarm1,
            "Code" : homeAssistantAlarm2,
        }
        var doc7 = new XMLHttpRequest();
        doc7.open("PUT", "file:///mnt/data/tsc/homeassistant.alarm.json");
        doc7.send(JSON.stringify(homeAssistantAlarmJson));

        getAlarmInfo();
    }

    function getAlarmInfo() {
        if (connected) {
            getHomeAssistant(homeAssistantAlarm1, function(data) {
                if (data) {
                    homeAssistantAlarmState = JSON.parse(data)['state'];

                    if (homeAssistantAlarmState == "disarmed") {
                        homeAssistantScreen.alarmR.alarmREnter.state = "off";
                    } else {
                        homeAssistantScreen.alarmR.alarmREnter.state = "on";
                    }

                    //Don't update alarmcode label when code is being entered
                    var alarmLastChar = homeAssistantAlarmCodeLabel.slice(-1);
                    if (!(/\d/.test(alarmLastChar))) {
                        homeAssistantAlarmCodeLabel = homeAssistantAlarmState;
                    }
                }
            });
        }
    }

    function init() {
        registry.registerWidget("tile", tileUrl, this, null, {thumbLabel: qsTr("homeAssistant"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
        registry.registerWidget("screen", homeAssistantConfigurationScreenUrl, this, "homeAssistantConfigurationScreen");
        registry.registerWidget("screen", homeAssistantScreenUrl, this, "homeAssistantScreen");
    }

    Component.onCompleted: {
        readDefaults();
    }

    function readDefaults() {
        try {
            homeAssistantSettingsJson = JSON.parse(userSettingsFile.read());
        } 
        catch (err) {
            logText("Error reading userSettings. " + err);
        }

        try {
            homeAssistantServer = homeAssistantSettingsJson ['Server'];
            homeAssistantPort = homeAssistantSettingsJson ['Port'];
            homeAssistantSSL = homeAssistantSettingsJson ['SSL'];

            if (homeAssistantSSL == "yes") {
                url = "https://" + homeAssistantServer + ":" + homeAssistantPort;
            } else {
                url = "http://" + homeAssistantServer + ":" + homeAssistantPort;
            }
        }
        catch (err) {
            logText("Error generating URL. " + err);
        }

        try {
            homeAssistantLegacy = homeAssistantSettingsJson ['Legacy'];
        }
        catch (err) {
            logText("Error reading Legacy setting")
            homeAssistantLegacy = 0;
        }

        if (!homeAssistantLegacy) {
            try {
                homeAssistantToken = tokenFile.read().trim();
                if (homeAssistantToken.length == 0) {
                    throw "Error: No token found";
                }
            }
            catch (err) {
                var doc8 = new XMLHttpRequest();
                doc8.open("PUT", "file:///mnt/data/tsc/homeassistant.token.txt");
                doc8.send('');
                logText("Please add access token to token.txt. " + err);
            }
        } else {
            try {
                homeAssistantPass = homeAssistantSettingsJson ['Pass'];
                
                urlPass = "?api_password=" + homeAssistantPass;
            }
            catch (err) {
                logText("Error generating URL password object. " + err);
            }
        }

        try {
            clockTile = homeAssistantSettingsJson ['Clock'];
        }
        catch (err) {
            clockTile = 0;
        }
        
        try {
            homeAssistantScenesJson = JSON.parse(scenesFile.read());
        }
        catch (err) {
            logText("Error reading scenesFile. " + err);
        }

        try {
            homeAssistantSwitchesJson = JSON.parse(switchFile.read());
        }
        catch (err) {
            logText("Error reading switchFile. " + err);
        }

        try {
            homeAssistantSensorsJson = JSON.parse(sensorFile.read());
        }
        catch (err) {
            logText("Error reading sensorFile. " + err);
        }

        try {
            homeAssistantSlidersJson = JSON.parse(slidersFile.read());
        }
        catch (err) {
            logText("Error reading slidersFile. " + err);
        }

        try {
            homeAssistantAlarmJson = JSON.parse(alarmFile.read());
        }
        catch (err) {
            logText("Error reading alarmFile. " + err);
        }

        try {
            homeAssistantScene1 = homeAssistantScenesJson ['Scene1'];
            homeAssistantScene2 = homeAssistantScenesJson ['Scene2'];
            homeAssistantScene3 = homeAssistantScenesJson ['Scene3'];
            homeAssistantScene4 = homeAssistantScenesJson ['Scene4'];
        }
        catch (err) {
            logText("Error loading scenes. " + err);
        }

        try {
            homeAssistantSlider1 = homeAssistantSlidersJson ['Slider1'];
        }
        catch (err) {
            logText("Error loading slider object. " + err);
        }
        
        homeAssistantSwitch1 = homeAssistantSwitchesJson ['Switch1'];
        homeAssistantSwitch2 = homeAssistantSwitchesJson ['Switch2'];
        homeAssistantSwitch3 = homeAssistantSwitchesJson ['Switch3'];
        homeAssistantSwitch4 = homeAssistantSwitchesJson ['Switch4'];
        homeAssistantSwitch5 = homeAssistantSwitchesJson ['Switch5'];
        
        homeAssistantSensor1 = homeAssistantSensorsJson ['Sensor1'];
        homeAssistantSensor2 = homeAssistantSensorsJson ['Sensor2'];
        homeAssistantSensor3 = homeAssistantSensorsJson ['Sensor3'];
        homeAssistantSensor4 = homeAssistantSensorsJson ['Sensor4'];
        homeAssistantSensor5 = homeAssistantSensorsJson ['Sensor5'];
        homeAssistantSensor6 = homeAssistantSensorsJson ['Sensor6'];
        homeAssistantSensor7 = homeAssistantSensorsJson ['Sensor7'];
        homeAssistantSensor8 = homeAssistantSensorsJson ['Sensor8'];

        homeAssistantAlarm1 = homeAssistantAlarmJson ['Alarm1'];
        homeAssistantAlarm2 = homeAssistantAlarmJson ['Code'];

        //Done loading connection settings into app
        checkConnection();
        
    }

    function getHomeAssistant(entity, callback) {
        if (entity == "") {
            callback(0);
        } else {
            var http = new XMLHttpRequest();
            var fullUrl = "";
            var urlExtension = entity ? "/api/states/" + entity : "/api/states";

            http.onreadystatechange = function() {
                if (http.readyState == 4) {
                    if (http.status == 200) {
                        callback(http.responseText);
                    } else {
                        logText("Get FAILED for object: " + entity + ". Response Status: " + http.status);
                        callback(http.status);
                    }
                }
            }

            fullUrl = url + urlExtension;

            if (!homeAssistantLegacy) {
                http.open("GET", fullUrl, true);
                http.setRequestHeader("Authorization", "Bearer " + homeAssistantToken);
                http.send();
            } else {
                //Only send password is there is one given
                if (homeAssistantPass) {
                    fullUrl = fullUrl + urlPass;
                }
                http.open("GET", fullUrl, true);
                http.send();
            }
        }
    }
    
    function setHomeAssistant(entity, state) {
        var http = new XMLHttpRequest();
        var fullUrl = "";
        var params = '{"entity_id": "' + entity + '"}';
        var type = entity.substr(0, entity.indexOf('.'));

        switch(type) {
            case "scene":
                fullUrl = url + "/api/services/scene/turn_on";
                break;
            case "switch":
                fullUrl = state ? url + "/api/services/" + type + "/turn_on" : url + "/api/services/" + type + "/turn_off";
                break;
            case "light":
                fullUrl = state ? url + "/api/services/" + type + "/turn_on" : url + "/api/services/" + type + "/turn_off";
                break;
            case "input_boolean":
                fullUrl = state ? url + "/api/services/" + type + "/turn_on" : url + "/api/services/" + type + "/turn_off";
                break;
            case "input_number":
                params = '{"entity_id": "' + entity + '", "value":"' + state + '"}';
                fullUrl = url + "/api/services/input_number/set_value";
                break;
            case "alarm_control_panel":
                params = state ? '{"entity_id": "' + entity + '", "code":"' + homeAssistantAlarm2 + '"}' : '{"entity_id": "' + entity + '", "code":"' + homeAssistantAlarmCode + '"}';
                fullUrl = state ? url + "/api/services/alarm_control_panel/alarm_arm_away" : url + "/api/services/alarm_control_panel/alarm_disarm";
                break;
            default:
                logText("Unable to work with object type: " + type + ".");
                return false;
        }

        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                if (http.status == 200) {
                    getSwitchInfo();
                    setSliderObject();
                    getAlarmInfo();
                    alarmInputReset();
                } else {
                    logText("Set FAILED for object: " + entity + ". Response Status: " + http.status);
                }
            }
        }

        if (connected) {
            http.open("POST", fullUrl, true);

            if (!homeAssistantLegacy) {
                http.setRequestHeader("Authorization", "Bearer " + homeAssistantToken);
            } else if (homeAssistantPass) {
                http.setRequestHeader("x-ha-access", homeAssistantPass);
            }

            http.setRequestHeader("Content-Type", "application/json");  
            http.send(params); 
        } else {
            logText("Not connected to HomeAssistant. Please verify connection settings.");
        }
    }

    function alarmInput(num) {
        if (homeAssistantAlarmCode.length < 5) {
            homeAssistantAlarmCode = homeAssistantAlarmCode + num;
            switch(homeAssistantAlarmCode.length) {
                case 1:
                    homeAssistantAlarmCodeLabel = num;
                    break;
                case 2:
                    homeAssistantAlarmCodeLabel = "*" + num;
                    break;
                case 3:
                    homeAssistantAlarmCodeLabel = "**" + num;
                    break;
                case 4:
                    homeAssistantAlarmCodeLabel = "***" + num;
                    break;
                default:
                    pass
            }
        }
    }

    function alarmInputReset() {
        homeAssistantAlarmCode = "";
        homeAssistantAlarmCodeLabel = homeAssistantAlarmState;
    }

}
