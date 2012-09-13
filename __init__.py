#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# Copyright (c) 2011 Benoit HERVIER <khertan@khertan.net>
# Licenced under GPLv3

## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published
## by the Free Software Foundation; version 3 only.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

from PySide.QtGui import QApplication, QMainWindow
from PySide.QtCore import QUrl, Slot, QObject, \
                          QAbstractListModel, QModelIndex
from PySide import QtDeclarative
from PySide.QtOpenGL import QGLWidget

import sys
import os.path

from pages_model import PagesModel

__version__ = '1.0'

class Window(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self, parent=None)
        self.view = QtDeclarative.QDeclarativeView()
        #For unknow reason, gl rendering didn't work on my installation
        #self.glw = QGLWidget()
        #self.view.setViewport(self.glw)

        self.pagesModel = PagesModel()

        self.rootContext = self.view.rootContext()
        self.rootContext.setContextProperty("argv", sys.argv)
        self.rootContext.setContextProperty("__version__", __version__)
        self.rootContext.setContextProperty('PagesModel', self.pagesModel)
        self.view.setSource(QUrl.fromLocalFile(
                os.path.join(os.path.dirname(__file__),
                             'qml', 'View.qml')))
        #self.view.showFullScreen()
        self.setCentralWidget(self.view)
        
class PyQmlTalk(QApplication):
    ''' Application class '''
    def __init__(self):
        QApplication.__init__(self, sys.argv)
        self.setOrganizationName("Khertan Software")
        self.setOrganizationDomain("khertan.net")
        self.setApplicationName("PyQmlTalk")

        self.window = Window()
        self.window.view.setResizeMode(QtDeclarative.QDeclarativeView.SizeRootObjectToView)
        self.window.showFullScreen() 

        
if __name__ == '__main__':
    sys.exit(PyQmlTalk().exec_())
