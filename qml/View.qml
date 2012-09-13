import QtQuick 1.1

Rectangle {
    id: view

    color: "black"
    focus: true
    
    Rectangle{
        id: leftButton
        width: 64
        height: parent.height
        anchors.left: parent.left
        anchors.top: parent.top
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

    ListView{
        id:listView
        orientation:ListView.Horizontal
        anchors.left: leftButton.right
        anchors.right: rightButton.left
        height: parent.height
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



    Rectangle{
        id: rightButton
        width: 64            
        height: parent.height
        anchors.top: parent.top
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
                font.pointSize: 32
                elide:Text.ElideRight
                text: content
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                
            }

            // Page Number
            Text{
                id:indexText
                width: parent.width
                color:"white"
                text:"page " + (index+1)
                font.pointSize: 9
                wrapMode : Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                height:20
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horinzontalCenter
            }
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
