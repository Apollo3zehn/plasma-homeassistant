import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property string cfg_url
    property alias cfg_flat: flat.checked
    property alias cfg_fontSize: fontSize.value
    property alias cfg_iconSize: iconSize.value
    property alias cfg_widgetWidth: widgetWidth.value
    property alias cfg_widgetHeight: widgetHeight.value
    property alias cfg_cellWidth: cellWidth.value
    property alias cfg_cellHeight: cellHeight.value
    property alias cfg_gridHorizontalSpacing: gridHorizontalSpacing.value
    property alias cfg_gridVerticalSpacing: gridVerticalSpacing.value

    signal configurationChanged

    Kirigami.FormLayout {
        Secrets {
            id: secrets
            property string token
            onReady: {
                restore(cfg_url)
                list().then(urls => (url.model = urls))
            }
            
            function restore(entryKey) {
                if (!entryKey) {
                    return this.token = ""
                }
                get(entryKey)
                    .then(t => this.token = t)
                    .catch(() => this.token = "")
            }
        }

        Item {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("API")
        }

        ComboBox {
            id: url
            editable: true
            onModelChanged: currentIndex = indexOfValue(cfg_url)
            onActiveFocusChanged: !activeFocus && setValue(editText)
            onHoveredChanged: !hovered && setValue(editText)
            onEditTextChanged: editText !== cfg_url && configurationChanged()
            onActivated: {
                secrets.restore(editText)
                setValue(editText)
            }
            Kirigami.FormData.label: i18n("Home Assistant URL")
            Layout.fillWidth: true

            function setValue(value) {
                cfg_url = editText = value ? value.replace(/\s+|\/+\s*$/g,'') : ''
            }
        }

        Label {
            text: i18n("Make sure the URL includes the protocol and port. For example:\nhttp://homeassistant.local:8123\nhttps://example.duckdns.org")
        }

        TextField {
            id: token
            text: secrets.token
            onTextChanged: text !== secrets.token && configurationChanged()
            Kirigami.FormData.label: i18n("Token")
        }

        Label {
            text: i18n("Get token from your profile page")
        }

        Label {
            text: `<a href="${url.editText}/profile">${url.editText}/profile</a>`
            onLinkActivated: link => Qt.openUrlExternally(link)
            visible: url.editText
        }

        Item {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Look")
        }

        CheckBox {
            id: flat
            Kirigami.FormData.label: i18n("Flat entities")
        }

        SpinBox {
            id: fontSize
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("Font size (pts)")
            from: 0
            to: 9999
        }

        SpinBox {
            id: iconSize
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("Icon size")
            from: -1
            to: 9999
        }

        SpinBox {
            id: widgetWidth
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("Widget width (-1 = default width)")
            from: -1
            to: 9999
        }

        Label {
            text: i18n("Sets the width of the widget within a horizontal panel")
        }

        SpinBox {
            id: widgetHeight
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("Widget height (-1 = default height)")
            from: -1
            to: 9999
        }

        Label {
            text: i18n("Sets the height of the widget within a vertical panel")
        }

        SpinBox {
            id: cellWidth
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("Cell width")
            from: 0
            to: 9999
        }

        SpinBox {
            id: cellHeight
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("Cell height")
            from: 0
            to: 9999
        }

        SpinBox {
            id: gridHorizontalSpacing
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("Horizontal spacing (-1 = default spacing)")
            from: -1
            to: 9999
        }

        SpinBox {
            id: gridVerticalSpacing
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("Vertical spacing (-1 = default spacing)")
            from: -1
            to: 9999
        }
    }
    
    function saveConfig() {
        secrets.set(url.editText, token.text)
    }
}