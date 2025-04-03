import QtQuick
import QtQuick.Layouts

import org.kde.plasma.extras as PlasmaExtras
import org.kde.plasma.components as PlasmaComponents3

import org.kde.kirigami as Kirigami

GridLayout {
    id: grid
    columns: model.show_name ? 2 : 3
    clip: true
    columnSpacing: Kirigami.Units.smallSpacing
    rowSpacing: 0

    DynamicIcon {
        name: model.icon
        Layout.rowSpan: model.show_name ? 2 : 1
        Layout.preferredWidth: Kirigami.Units.iconSizes.small
    }

    PlasmaExtras.Heading {
        id: stateValue
        level: 4
        text: model.value === 'unavailable ' ? 'N/A' : model.value
        elide: Text.ElideRight
        visible: !!text
        wrapMode: Text.NoWrap
        font.pixelSize: 8
        font.weight: Font.Bold
        Layout.fillWidth: true
    }

    PlasmaComponents3.Label {
        id: label
        text: name
        elide: Text.ElideRight
        visible: model.show_name
        font.pixelSize: 8
        Layout.alignment: model.value ? Qt.AlignTop : 0
        Layout.fillWidth: true
    }
}
