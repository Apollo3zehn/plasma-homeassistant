import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.extras as PlasmaExtras
import org.kde.plasma.components as PlasmaComponents3

import org.kde.kirigami as Kirigami

import "components"

PlasmaExtras.Representation {
    readonly property var appletInterface: plasmoid.self

    // Layout.preferredWidth: Kirigami.Units.gridUnit * 24
    // Layout.preferredHeight: Kirigami.Units.gridUnit * 24
    // Layout.minimumWidth: Kirigami.Units.gridUnit * 15
    // Layout.maximumWidth: Kirigami.Units.gridUnit * 15
    Layout.preferredWidth: Kirigami.Units.gridUnit * 20 //Layout.minimumWidth

    Loader {
        id: gridLoader
        sourceComponent: gridComponent
        active: root.initialized
        anchors.fill: parent
    }

    Component {
        id: gridComponent
        ScrollView {
            GridView {
                interactive: false
                clip: true
                readonly property int dynamicColumnNumber: Math.min(Math.max(width / minItemWidth, 1), count)
                readonly property int dynamicCellWidth: Math.max(width / dynamicColumnNumber, minItemWidth)
                readonly property int minItemWidth: Kirigami.Units.iconSizes.enormous

                cellWidth: 60
                cellHeight: 25
                model: itemModel
                delegate: EntityDelegateTile {
                    width: 60
                    height: 25
                }
            }
        }
    }

    StatusIndicator {
        icon: "data-error"
        size: Kirigami.Units.iconSizes.small
        message: ha?.errorString || ''
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
    }

    Loader {
        width: parent.width
        anchors.centerIn: parent
        active: ClientFactory.error
        sourceComponent: PlasmaExtras.PlaceholderMessage {
            text: i18n("Failed to create WebSocket client")
            explanation: ClientFactory.errorString().split(/\:\d+\s/)[1]
            iconName: "error"
            helpfulAction: Action {
                icon.name: "link"
                text: i18n("Show requirements")
                onTriggered: Qt.openUrlExternally(`${plasmoid.metaData.website}/tree/v${plasmoid.metaData.version}#requirements`)
            }
        }
    }

    Loader {
        anchors.centerIn: parent
        active: plasmoid.configurationRequired
            && (plasmoid.formFactor === PlasmaCore.Types.Vertical
            || plasmoid.formFactor === PlasmaCore.Types.Horizontal)
        sourceComponent: PlasmaComponents3.Button {
            icon.name: "configure"
            text: i18nd("plasmashellprivateplugin", "Configure…")
            onClicked: plasmoid.internalAction("configure").trigger()
        }
    }
}
