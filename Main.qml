import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItems

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "application.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    property string locale: ""

    Page {
        title: i18n.tr("application")

        Flickable {
            anchors.fill: parent
            contentHeight: content.childrenRect.height

            Column {
                id: content
                anchors.fill: parent
                spacing: units.gu(0.5)

                ListItems.SingleValue {
                    text: "Active"
                    value: Qt.application.state == Qt.ApplicationActive
                }

                ListItems.SingleValue {
                    text: "State"
                    value: {
                        switch(Qt.application.state) {
                        case Qt.ApplicationActive:
                            return "Active";
                        case Qt.ApplicationInactive:
                            return "Inactive";
                        case Qt.ApplicationSuspended:
                            return "Suspended";
                        case Qt.ApplicationHidden:
                            return "Hidden";
                        default:
                            return "Unknown";
                        }
                    }
                }

                ListItems.SingleValue {
                    text: "Layout direction"
                    value: {
                        switch(Qt.application.layoutDirection) {
                        case Qt.LeftToRight:
                            return "Left to right";
                        case Qt.RightToLeft:
                            return "Right to left";
                        default:
                            return "Unknown";
                        }
                    }
                }

                ListItems.Subtitled {
                    text: "aruguments"
                    subText: {
                        console.log("arguments: " + Qt.application.arguments);
                        var arguments = Qt.application.arguments;
                        var content = arguments.join(" ");
                        return content;
                    }
                }

                ListItems.SingleValue {
                    text: "name"
                    value: Qt.application.name
                }

                ListItems.SingleValue {
                    text: "domain"
                    value: {
                        console.log("version: " + Qt.application.version);
                        return Qt.application.domain;
                    }
                }

                ListItems.SingleValue {
                    text: "support multiple windows"
                    value: Qt.application.supportsMultipleWindows
                }

                ListItems.SingleValue {
                    text: "OS"
                    value: Qt.platform.os
                }

                ListItems.SingleValue {
                    text: "Locale"
                    value: locale
                }
            }
        }

        Component.onCompleted: {
            var keys = Object.keys(Qt.application);
            for(var i = 0; i < keys.length; i++) {
                var key = keys[i];
                // prints all properties, signals, functions from object
                console.log(key + ' : ' + Qt.application[key]);
            }

            locale = Qt.inputMethod["locale"].nativeLanguageName;
            console.log("locale: " + locale);
        }
    }
}
