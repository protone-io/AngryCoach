import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

SearchList {
    id: searchFood
    property string mode: "Food"
    signal add();
    signal editItem(string itemId);
    signal deleteItem(string itemId);
//    title: mode === "Food" ? qsTr("Choose food to add") : qsTr("Choose recipe to add")
    visible: false
//    model: mode === "Food" ? dataManager.food : dataManager.recipes
    defaultModelField: "Name"
    listView {
        delegateModel.delegate: BaseListItem {
            id: listDelegate
            elevation: 1
            property int modelIndex: index
            height: dp(50)
            onClicked: {
                listView.itemClicked(modelIndex)
            }
            onPressAndHold: {
                contextMenu.foodId = modelData["Id"];
                contextMenu.title = modelData["Name"];
                contextMenu.open();
            }

            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 16 * Units.dp
                anchors.verticalCenter: parent.verticalCenter
                text: {
                    return modelData["Name"];
                }
            }
        }
    }

    BottomActionSheet {
        id: contextMenu
        property string foodId;
        actions: [
            Action {
                name: qsTr("Edit")
                onTriggered: {
                    editItem(contextMenu.foodId);
                }
            },
            Action {
                name: qsTr("Delete")
                onTriggered: {
                    deleteItem(contextMenu.foodId)
                }
            }

        ]
    }
    
    StandardActionButton {
        AwesomeIcon {
            anchors.centerIn: parent
            color: Palette.colors.white["500"]
            name: "plus"
        }
        
        onClicked: {
            add();
        }
    }

}
