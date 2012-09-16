import QtQuick 1.1

Rectangle {
    id: view

    color: "black"
    focus: true
    
    Rectangle {
        id:header
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.leftMargin: 10
            anchors.rightMargin: 10        
            anchors.left: parent.left    
            anchors.right: parent.right
            color: "black"
        
            height: logo.height
            
            Image {
                id:logo
                anchors.top: parent.top
                anchors.left: parent.left
                source: Qt.resolvedUrl("images/pyconfr_paris.png")
                fillMode: Image.PreserveAspectFit
            }
            
            // Page Number and title
            Text{
                        id:indexText
                        color:"white"
                        text:"Développement d'applications Mobile avec Python et Qt : Page " + listView.currentIndex
                        font.pointSize: header.width>0 ? 16 * header.width / 1660 : 16
                        wrapMode : Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        visible: listView.currentIndex > 0 ? true : false;
            }
            onWidthChanged: {console.log( header.width); }
    }
            
    Rectangle{
        id: leftButton
        width: 64
        anchors.left: parent.left
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        color: "black"
        Image {
            id: leftArrow
            source: Qt.resolvedUrl("images/left_arrow.png")
            width: 26
            anchors.centerIn: parent
        }
        MouseArea {
         anchors.fill: parent
         onClicked: { previousPage(); }
        }
    }


    Rectangle{
        id: rightButton
        width: 64            
        height: parent.height
        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "black"
        Image {
            id: rightArrow
            source: Qt.resolvedUrl("images/right_arrow.png")
            width: 26
            anchors.centerIn: parent
        }
        MouseArea {
         anchors.fill: parent
         onClicked: { nextPage(); }
        }
        
        
    }

    ListView{
        id:listView
        orientation:ListView.Horizontal
        anchors.left: leftButton.right
        anchors.right: rightButton.left
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        model:PagesModel
        delegate:myDelegate
        maximumFlickVelocity:700
        snapMode: ListView.SnapToItem
        preferredHighlightBegin: 0; preferredHighlightEnd: 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightFollowsCurrentItem: true

        onCurrentIndexChanged: {
            if(listView.currentIndex == 0) leftArrow.visible = false;
            else leftArrow.visible = true;

            if(listView.currentIndex == listView.count-1) rightArrow.visible = false;
            else rightArrow.visible = true;
        }
    }        
    

    Component{
        id:myDelegate

        Rectangle {
            width:ListView.view.width
            height:ListView.view.height
            color: "black"
            
            // Content
            Text{
                id:contentText
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                color:"white"
                font.pointSize: listView.height>0 ? 32 * listView.height / 950 : 32
                elide:Text.ElideRight
                text: content
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
            }
            onHeightChanged: {console.log( listView.height); }

        }
    }

    Keys.onPressed: { 
        if (event.key == Qt.Key_Left) previousPage();
        if (event.key == Qt.Key_Right) nextPage();
    }
     
    function nextPage() {
        if (listView.currentIndex+1 < listView.count)
            listView.currentIndex = listView.currentIndex+1;
    }
    function previousPage() {
        if (listView.currentIndex > 0)
            listView.currentIndex = listView.currentIndex-1;
    }

}
