import QtQuick
import qs.Components

Item {
    id: root
    property int innerRadius: 34
    property int outerRadius: 48
    property int barCount: 40
    property color fillColor: "#fff"
    property color strokeColor: "#fff"
    property int strokeWidth: 0

    width: outerRadius * 2
    height: outerRadius * 2

    // Cava input
    Cava {
        id: cava
        count: root.barCount
    }

    Repeater {
        model: root.barCount
        Rectangle {
            property real value: cava.values[index]
            property real angle: (index / root.barCount) * 360
            width: Math.max(2, (root.innerRadius * 2 * Math.PI) / root.barCount - 4)
            height: value * (root.outerRadius - root.innerRadius)
            radius: width / 2
            color: root.fillColor
            border.color: root.strokeColor
            border.width: root.strokeWidth
            antialiasing: true

            x: root.width / 2 + (root.innerRadius) * Math.cos(Math.PI / 2 + 2 * Math.PI * index / root.barCount) - width / 2
            y: root.height / 2 - (root.innerRadius) * Math.sin(Math.PI / 2 + 2 * Math.PI * index / root.barCount) - height

            transform: Rotation {
                origin.x: width / 2
                origin.y: height
                angle: -angle
            }

            Behavior on height {
                SmoothedAnimation {
                    duration: 120
                }
            }
        }
    }
}
