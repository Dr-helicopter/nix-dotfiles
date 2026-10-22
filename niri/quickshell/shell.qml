import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick

Scope {
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

	// Clock component
    PanelWindow {
		anchors.top: true
			implicitHeight: 6

		color: "transparent"

		CornerPanel { 
			corner: "tr" 
			anchors {
				left: true
				top: true
			}

			input_tag: "cl"

			margins.left: 105

			Text {
				color: "#13c299"
				font.pixelSize: 20
				font.bold: true
				font.family: "Terminess Nerd Font"
			}	
		}

		CornerPanel { 
			corner: "tl" 

			anchors {
				right: true
				top: true
			}

			input_tag: "cr"

			margins {
				right: 105
			}
			Text {
				color: "#13c299"
				font.pixelSize: 20
				font.bold: true
				font.family: "Terminess Nerd Font"
			}	
		}


		PanelWindow {
			anchors.top: true
			implicitWidth: 170
			implicitHeight: 26

			exclusionMode: ExclusionMode.Ignore
			color: "transparent"
			Canvas {
				id: top_clock
				anchors.fill: parent

				onPaint: {
					const ctx = getContext("2d")
					ctx.clearRect(0, 0, width, height)

					ctx.fillStyle = "#000000"
					ctx.beginPath()
					ctx.moveTo(0, 0)
					ctx.lineTo(width, 0)
					ctx.lineTo(width - 26, height)
					ctx.lineTo(26, height)
					ctx.closePath()
					ctx.fill()

					ctx.beginPath()
					ctx.moveTo(0, 0)
					ctx.lineTo(26, height)
					ctx.lineTo(width - 26, height)
					ctx.lineTo(width, 0)

					ctx.strokeStyle = "#13c299"
					ctx.lineWidth = 5
					ctx.stroke()
				}
			}

			Text {
				anchors.centerIn: parent
				text: Qt.formatDateTime(clock.date, "HH:mm:ss")
				color: "#13c299"
				font.pixelSize: 20
				font.bold: true
				font.family: "Terminess Nerd Font"

			
			}
		}
    }

    // Generic, file-driven corner component.
    component CornerPanel: PanelWindow {
        id: cornerPanel

        required property string corner
		property string input_tag


        readonly property bool isTop: corner.startsWith("t")
        readonly property bool isLeft: corner.endsWith("l")

        readonly property color accentColor: {
            const value = colorFile.text().trim()
            return value.length > 0 ? value : "#24dfc4"
        }

        readonly property real targetWidth:
            Math.max(20, cornerText.implicitWidth + 28)

		readonly property string file_tag: input_tag ? input_tag : corner

        // Stable Wayland surface; only the shape animates.
        implicitWidth: 800
        implicitHeight: 20

        exclusionMode: ExclusionMode.Ignore
        color: "transparent"

        FileView {
            id: textFile
            path: "/dev/shm/qshell/" + cornerPanel.file_tag + "-text"
            watchChanges: true
            printErrors: true

            onFileChanged: reload()
        }

        FileView {
            id: colorFile
            path: "/dev/shm/qshell/" + cornerPanel.corner + "-color"
            watchChanges: true
            printErrors: true

            onFileChanged: reload()
        }

        Item {
            id: shape
            anchors.top: parent.top
            anchors.left: cornerPanel.isLeft ? parent.left : undefined
            anchors.right: cornerPanel.isLeft ? undefined : parent.right

            width: cornerPanel.targetWidth
            height: parent.height
            clip: true

            Behavior on width {
                NumberAnimation {
                    duration: 350
                    easing.type: Easing.OutCubic
                }
            }

            Canvas {
                id: shapeCanvas
                anchors.fill: parent

                onPaint: {
                    const ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)

                    const w = width
                    const h = height
                    const left = cornerPanel.isLeft
                    const top = cornerPanel.isTop

                    ctx.fillStyle = "#000000"
                    ctx.beginPath()

                    if (left && top) {
                        ctx.moveTo(0, 0)
                        ctx.lineTo(w, 0)
                        ctx.lineTo(w - 20, h)
                        ctx.lineTo(0, h)
                    } else if (!left && top) {
                        ctx.moveTo(w, 0)
                        ctx.lineTo(0, 0)
                        ctx.lineTo(20, h)
                        ctx.lineTo(w, h)
                    } else if (left && !top) {
                        ctx.moveTo(0, h)
                        ctx.lineTo(w, h)
                        ctx.lineTo(w - 20, 0)
                        ctx.lineTo(0, 0)
                    } else {
                        ctx.moveTo(w, h)
                        ctx.lineTo(0, h)
                        ctx.lineTo(20, 0)
                        ctx.lineTo(w, 0)
                    }

                    ctx.closePath()
                    ctx.fill()

                    ctx.beginPath()

                    if (left && top) {
                        ctx.moveTo(0, h)
                        ctx.lineTo(w - 20, h)
                        ctx.lineTo(w, 0)
                    } else if (!left && top) {
                        ctx.moveTo(w, h)
                        ctx.lineTo(20, h)
                        ctx.lineTo(0, 0)
                    } else if (left && !top) {
                        ctx.moveTo(0, 0)
                        ctx.lineTo(w - 20, 0)
                        ctx.lineTo(w, h)
                    } else {
                        ctx.moveTo(w, 0)
                        ctx.lineTo(20, 0)
                        ctx.lineTo(0, h)
                    }

                    ctx.strokeStyle = cornerPanel.accentColor
                    ctx.lineWidth = 5
                    ctx.stroke()
                }

                Connections {
                    target: shape

                    function onWidthChanged() {
                        shapeCanvas.requestPaint()
                    }
                }

                Connections {
                    target: cornerPanel

                    function onAccentColorChanged() {
                        shapeCanvas.requestPaint()
                    }
                }
            }

            Text {
                id: cornerText

                anchors.left: cornerPanel.isLeft ? parent.left : undefined
                anchors.right: cornerPanel.isLeft ? undefined : parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                anchors.leftMargin: cornerPanel.isLeft ? 4 : 0
                anchors.rightMargin: cornerPanel.isLeft ? 0 : 4

                text: textFile.text().trim()
                color: cornerPanel.accentColor

                font.pixelSize: 20
                font.bold: true
                font.family: "Terminess Nerd Font"

                verticalAlignment: Text.AlignVCenter
            }
        }
    }

	CornerPanel { 
		corner: "tl" 
        anchors.top: true
		anchors.left: true
	}
	CornerPanel { 
		corner: "tr" 
        anchors.top: true
        anchors.right: true
	}
	CornerPanel { 
		corner: "bl" 
        anchors.bottom: true
		anchors.left: true
	}
	CornerPanel { 
		corner: "br" 
        anchors.bottom: true
        anchors.right: true
	}
}
