import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

/*
* 20200202: dEADkIRK added TOON2 resolution
*/
Tile {
	id: homeAssistantTile

	function init() {}

	onClicked: {
		if (app.homeAssistantScreen)
			app.homeAssistantScreen.show();
	}

	Text {
		id: txtTimeBig
		text: app.timeStr
		color: colors.clockTileColor
		anchors {
			left: parent.left
			leftMargin: 10
			baseline: parent.top
			baselineOffset: isNxt ? 67 : 54
		}
		font {
			family: qfont.regular.name
			pixelSize: dimState ? qfont.clockFaceText : qfont.timeAndTemperatureText - isNxt ? 5 : 4
		}
		visible: app.clockTile ? true : false
	}

	Text {
		id: txtDate
		text: app.dateStr
		color: colors.clockTileColor
		anchors {
			left: txtTimeBig.left
			top: txtTimeBig.bottom
			topMargin: -10
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: qfont.tileTitle - 2
		font.family: qfont.regular.name
		visible: app.clockTile ? !dimState : false
	}

	Image {
		id: homeAssistantIconSmall
		source: "qrc:/tsc/homeAssistantIconSmall.png"
		anchors {
			bottom: txtDate.bottom
			right: parent.right
			rightMargin: 10
		}
		cache: false
		visible: app.clockTile ? !dimState : false
	}

	Image {
		id: homeAssistantIconSmallCenter
		source: dimState ? "qrc:/tsc/homeAssistantIconSmallDim.png" : "qrc:/tsc/homeAssistantIconSmall.png"
		anchors {
			baseline: parent.top
			horizontalCenter: parent.horizontalCenter
			baselineOffset: isNxt ? 19 : 15
		}
		cache: false
		visible: app.clockTile ? false : true
	}

	Rectangle {
        id: tileGrid
        color: "transparent"
		width: parent.width - 20
		height: isNxt ? 75 : 60
		anchors {
			bottom: parent.bottom
			left: parent.left
			bottomMargin: 10
			leftMargin: 10
		}

		Text {
			id: lblSensor1
			text: try { JSON.parse(app.homeAssistantSensor1Info)['attributes']['friendly_name'] } catch(e) { "" }
			color: colors.clockTileColor
			height: isNxt ? 25 : 20
			width: tileGrid.width - isNxt ? 50 : 40
			anchors {
				left: parent.left
				top: parent.top
			}
			font.pixelSize: isNxt ? 15 : 12
			font.family: qfont.regular.name
			font.bold : true
		}

		Text {
			id: valueSensor1
			text: try { (JSON.parse(app.homeAssistantSensor1Info)['state'] + " " + JSON.parse(app.homeAssistantSensor1Info)['attributes']['unit_of_measurement']).replace("undefined", "") } catch(e) { try { JSON.parse(app.homeAssistantSensor1Info)['state'] } catch(e) { "" } }
			color: colors.clockTileColor
			height: isNxt ? 25 : 20
			width: isNxt ? 50 : 40
			anchors {
				right: parent.right
				top: lblSensor1.top
				rightMargin: 0
			}
			font.pixelSize: isNxt ? 15 : 12
			font.family: qfont.regular.name
			font.bold : true
		}

		Text {
			id: lblSensor2
			text: try { JSON.parse(app.homeAssistantSensor2Info)['attributes']['friendly_name'] } catch(e) { "" }
			color: colors.clockTileColor
			height: isNxt ? 25 : 20
			width: tileGrid.width - isNxt ? 50 : 40
			anchors {
				left: parent.left
				top: lblSensor1.bottom
			}
			font.pixelSize: isNxt ? 15 : 12
			font.family: qfont.regular.name
			font.bold : true
		}

		Text {
			id: valueSensor2
			text: try { (JSON.parse(app.homeAssistantSensor2Info)['state'] + " " + JSON.parse(app.homeAssistantSensor2Info)['attributes']['unit_of_measurement']).replace("undefined", "") } catch(e) { try { JSON.parse(app.homeAssistantSensor2Info)['state'] } catch(e) { "" } }
			color: colors.clockTileColor
			height: isNxt ? 25 : 20
			width: isNxt ? 50 : 40
			anchors {
				right: parent.right
				top: lblSensor2.top
			}
			font.pixelSize: isNxt ? 15 : 12
			font.family: qfont.regular.name
			font.bold : true
		}

		Text {
			id: lblSensor3
			text: try { JSON.parse(app.homeAssistantSensor3Info)['attributes']['friendly_name'] } catch(e) { "" }
			color: colors.clockTileColor
			height: isNxt ? 25 : 20
			width: tileGrid.width - isNxt ? 50 : 40
			anchors {
				left: parent.left
				top: lblSensor2.bottom
			}
			font.pixelSize: isNxt ? 15 : 12
			font.family: qfont.regular.name
			font.bold : true
		}

		Text {
			id: valueSensor3
			text: try { (JSON.parse(app.homeAssistantSensor3Info)['state'] + " " + JSON.parse(app.homeAssistantSensor3Info)['attributes']['unit_of_measurement']).replace("undefined", "") } catch(e) { try { JSON.parse(app.homeAssistantSensor3Info)['state'] } catch(e) { "" } }
			color: colors.clockTileColor
			height: isNxt ? 25 : 20
			width: isNxt ? 50 : 40
			anchors {
				right: parent.right
				top: lblSensor3.top
			}
			font.pixelSize: isNxt ? 15 : 12
			font.family: qfont.regular.name
			font.bold : true
		}
	}
}
