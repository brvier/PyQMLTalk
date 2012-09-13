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

from PySide.QtGui import QApplication
from PySide.QtCore import QUrl, Slot, QObject, \
                          QAbstractListModel, QModelIndex
from PySide import QtDeclarative
from PySide.QtOpenGL import QGLWidget

import sys
import os.path

from markdown import markdown

class Page(object):
    def __init__(self, filename):
        self.filename = filename
        with open(os.path.join(os.path.dirname(__file__), 'pages', filename), 'r') as fh:
            self.content = markdown(unicode(fh.read(), 'utf-8'), extensions=['nb2lr',])
        
class PagesModel(QAbstractListModel):
    COLUMNS = ('filename', 'content', 'index')

    def __init__(self, ):
        self._pages = {}
        QAbstractListModel.__init__(self)
        self.setRoleNames(dict(enumerate(PagesModel.COLUMNS)))
        self._filter = None
        self.loadData()
        
    def loadData(self,):
        self._pages = [Page(filename=filename.decode('utf-8'))
                       for filename in os.listdir(os.path.join(os.path.dirname(__file__), 'pages'))
                       if (os.path.isfile(os.path.join(os.path.dirname(__file__), 'pages', filename)))
                       and (filename.endswith('.md'))]

        self._pages.sort(key=lambda page: page.filename, reverse=False)
        
        
    def rowCount(self, parent=QModelIndex()):
        return len(self._pages)

    def data(self, index, role):
        if index.isValid() and role == PagesModel.COLUMNS.index('filename'):
            return self._pages[index.row()].filename
        elif index.isValid() and role == PagesModel.COLUMNS.index('content'):
            return self._pages[index.row()].content
        elif index.isValid() and role == PagesModel.COLUMNS.index('index'):
            return index.row()
        return None

    @Slot()
    def reload(self):
        self.beginResetModel()
        self.loadData()
        self.endResetModel()
