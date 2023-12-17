var MAX_SCALE = 5;
var MIN_SCALE = 1;

function getCaretY() {
    var x = 0, y = 0;
    var sel = window.getSelection();
    if (sel.rangeCount) {

        var range = sel.getRangeAt(0);
        var needsToWorkAroundNewlineBug = (range.startContainer.nodeName.toLowerCase() == 'div'
            && range.startOffset == 0);
        if (needsToWorkAroundNewlineBug) {
            x = range.startContainer.offsetLeft;
            y = range.startContainer.offsetTop;
        } else {
            if (range.getClientRects) {
                var rects = range.getClientRects();
                if (rects.length > 0) {
                    x = rects[0].left;
                    y = rects[0].top;
                }
            }
        }
    }
    return y;
}

function appendEndTag() {
    if (document.getElementById('endTag') == null || document.getElementById('endTag') == '') {
        var hr = document.createElement('hr');
        hr.setAttribute('id', 'endTag');
        document.body.appendChild(hr);
    }
}

function getPosEnd() {
    appendEndTag();
    var top = document.getElementById('endTag').offsetTop;
    var height = document.getElementById('endTag').offsetHeight;
    return top + height;
}

function updateStyle(width) {
    document.body.style.width = width;
    if (document.getElementById('myEditableDiv') != null && document.getElementById('myEditableDiv') != '') {
        document.getElementById('myEditableDiv').style.width = width;
    }
}

function setViewportMaxScale(zoomScale = 1, minScale = 1, maxScale = 1) {
    var viewportContent = 'width=device-width, initial-scale=' + zoomScale + ',minimum-scale= ' + minScale + ',maximum-scale=' + maxScale + ',user-scalable=no';
    var vps = document.getElementsByTagName('meta');
    for (i = 0; i < vps.length; i++) {
        if (vps[i].getAttribute('name') != null && vps[i].getAttribute('name') == 'viewport') {
            vps[i].setAttribute('content', viewportContent);
        }
    }
}

function setEditorMinHeight(height) {
    var editor = document.getElementById('myEditableDiv');
    var minHeightDesc = window.getComputedStyle(editor, null).getPropertyValue('min-height');
    var minHeight = minHeightDesc.match(/[a-z%]+|[^a-z%]+/gi);
    if (minHeight[0] != height) {
        document.getElementById('myEditableDiv').style.minHeight = height;
        return true;
    }
    return false;
}

function withWiderObject(scale, screenWidth) {
    var elemWidthDesc = '';
    var elems = document.body.getElementsByTagName('*');
    for (i = 0; i < elems.length; i++) {
        if (elems[i].getAttribute('width') != null && elems[i].getAttribute('width') != '') {
            elemWidthDesc = elems[i].getAttribute('width');
        } else if (elems[i].style.width != null && elems[i].style.width != '') {
            elemWidthDesc = elems[i].style.width;
        }
        if (elemWidthDesc != '' && isWider(scale, elemWidthDesc, screenWidth)) {
            return true;
        }
    }
    return false;
}

function isWider(scale, elemWidthDesc, screenWidth) {
    var unitWidth = getUnit(elemWidthDesc);
    if (unitWidth != '%') {
        return ptConverter(elemWidthDesc) * scale > screenWidth;
    }
    return false;
}

function getUnit(value) {
    var valueDesc = value.match(/[a-z%]+|[^a-z%]+/gi);
    if (valueDesc.length > 1) {
        return valueDesc[1];
    } else {
        return '';
    }
}

function getValue(value) {
    var valueDesc = value.match(/[a-z%]+|[^a-z%]+/gi);
    return valueDesc[0];
}

function getMax(val1, val2) {
    return Math.max(parseInt(val1), parseInt(val2));
}

function ptConverter(valueWithUnit) {
    if (valueWithUnit == '') {
        return 0;
    } else {
        var value = parseInt(getValue(valueWithUnit));
        var unit = getUnit(valueWithUnit);
        if (unit == 'px') {
            return value * 6 / 8;
        } else if (unit == 'cm') {
            return value * 28.3465;
        } else if (unit == 'em') {
            return value * 6 / 0.5;
        }
        return value;
    }
}

function adjustTableBestfit(isBestfit, screenWidth, scale = 1, isResume = false) {
    var maxWidth = 0;
    var result = '';
    var tables = document.getElementsByTagName('table');
    for (i = 0; i < tables.length; i++) {
        var tableWidthInPercentage = '';
        var tableResultWidth = '';
        var tableStyleWidth = '';
        var tableWidth = '';
        if (tables[i].style.width != null && tables[i].style.width != '' && getValue(tables[i].style.width) != 0) {
            tableStyleWidth = tables[i].style.width;
            if (getUnit(tableStyleWidth) == '%') {
                tableWidthInPercentage = tableStyleWidth;
                tableStyleWidth = screenWidth * (getValue(tableStyleWidth) / 100);
            }
        }
        if (tables[i].getAttribute('width') != null && tables[i].getAttribute('width') != '' && getValue(tables[i].getAttribute('width')) != 0) {
            tableWidth = tables[i].getAttribute('width');
            if (getUnit(tableWidth) == '%') {
                if (tableWidthInPercentage == '') {
                    tableWidthInPercentage = tableWidth;    // use element.style.width first
                }
                tableWidth = screenWidth * (getValue(tableWidth) / 100);
            }
        }
        var unit = '';
        var maxRowWidth = 0;
        var rows = tables[i].getElementsByTagName('tr');
        for (j = 0; j < rows.length; j++) {
            var totalCellWidth = 0;
            var cellStyleWidth = '';
            var cellWidth = '';
            var cells = rows[j].getElementsByTagName('td');
            for (k = 0; k < cells.length; k++) {
                var maxCellWidth = 0;
                if (cells[k].style.width != null && cells[k].style.width != '') {
                    cellStyleWidth = cells[k].style.width;
                }
                if (cells[k].getAttribute('width') != null && cells[k].getAttribute('width') != '') {
                    cellWidth = cells[k].getAttribute('width');
                }
                maxCellWidth = getMax(ptConverter(cellStyleWidth), ptConverter(cellWidth));
                totalCellWidth += maxCellWidth;
            }
            maxRowWidth = getMax(maxRowWidth, totalCellWidth);
        }
        tableResultWidth = getMax(getMax(ptConverter(tableStyleWidth), ptConverter(tableWidth)), maxRowWidth);
        // set width if and only if element with properties of width
        if (tableResultWidth != '') {
            if (tableWidthInPercentage == '') {
                tables[i].setAttribute('width', tableResultWidth);
            } else {
                tables[i].setAttribute('width', tableWidthInPercentage);
            }
            if (isResume) {
                tables[i].style.width = tableResultWidth;
            } else {
                if (isBestfit == true && tableResultWidth > screenWidth) {
                    tables[i].style.width = screenWidth;
                } else {
                    // restrict the max table width = screen width * 5
                    tables[i].style.width = Math.min(tableResultWidth * Math.max(1, scale), screenWidth * MAX_SCALE);
                }
            }
            maxWidth = getMax(maxWidth, tableResultWidth);
        }
    }
    return maxWidth;
}

function adjustImageBestfit(isBestfit, screenWidth, scale = 1, isResume = false) {
    var maxWidth = 0;
    var result = '';
    var images = document.getElementsByTagName('img');
    for (i = 0; i < images.length; i++) {
        // bug fix on assigned the width incorrectly
        if ((images[i].getAttribute('width') != null && images[i].getAttribute('width') == '100%') && (images[i].style.width != null && images[i].style.width == '100%') && (images[i].style.maxWidth != null && images[i].style.maxWidth == '100%')) {
            images[i].removeAttribute('style');
            images[i].removeAttribute('width');
        }
        var imageWidth = '';
        if (images[i].style.width != null && images[i].style.width != '' && getValue(images[i].style.width) != 0) {
            imageWidth = images[i].style.width;
        }
        if (images[i].getAttribute('width') != null && images[i].getAttribute('width') != '' && getValue(images[i].getAttribute('width')) != 0) {
            imageWidth = images[i].getAttribute('width');
        }
        // set width if and only if element with properties of width
        if (imageWidth != '') {
            images[i].setAttribute('width', imageWidth);
            if (isResume) {
                images[i].style.width = imageWidth;
            } else {
                var imageWidthInPt = ptConverter(imageWidth);
                if (isBestfit == true && imageWidthInPt > screenWidth) {
                    images[i].style.width = '100%';
                } else {
                    // restrict the max image width = screen width * 5 or 500%
                    if (getUnit(imageWidth) == '%') {
                        images[i].style.width = Math.min(getValue(imageWidth) * Math.max(1, scale), 500) + '%';
                        images[i].style.maxWidth = Math.min(getValue(imageWidth) * Math.max(1, scale), 500) + '%';
                    } else {
                        images[i].style.width = Math.min(imageWidthInPt * Math.max(1, scale), screenWidth * MAX_SCALE);
                        images[i].style.maxWidth = Math.min(imageWidthInPt * Math.max(1, scale), screenWidth * MAX_SCALE);
                    }
                }
                if (getUnit(imageWidth) != '%') {
                    maxWidth = getMax(maxWidth, ptConverter(imageWidth));
                }
            }
        }
    }
    return maxWidth;
}

function withAdjustableObject() {
    var tables = document.getElementsByTagName('table');
    var images = document.getElementsByTagName('img');
    removeUselessAttribute(document.body);
    removeUselessAttribute(document.getElementById('myEditableDiv'));
    if (tables.length > 0 || images.length > 0) {
        return true;
    } else {
        return false;
    }
}

function removeUselessAttribute(elem) {
    if (elem.style.width != null && elem.style.width != '') {
        removeCustomStyle(elem);
    } else if (elem.getAttribute('width') != null && elem.getAttribute('width') != '') {
        elem.removeAttribute('width');
    }
}

function resumeStyle(screenWidth, isResumeAll) {
    removeCustomStyle(document.body);
    removeCustomStyle(document.getElementById('myEditableDiv'));
    if (isResumeAll) {
        adjustTableBestfit(false, screenWidth, true);
        adjustImageBestfit(false, screenWidth, true);
    }
}

function removeCustomStyle(elem) {
    elem.style.width = null;
    var elemStyle = elem.getAttribute('style');
    if (elemStyle.length == 0) {
        elem.removeAttribute('style');
    }
}

function resumeAdjustableObject(tagName) {
    var elems = document.getElementsByTagName(tagName);
    for (i = 0; i < elems.length; i++) {
        if (elems[i].getAttribute('width') != null && elems[i].getAttribute('width') != '') {
            elems[i].style.width = null;
            var elemStyle = elems[i].getAttribute('style');
            if (elemStyle.length == 0) {
                elems[i].removeAttribute('style');
            }
        }
    }
}
var editor = null;
function initSunEditor() {
    editor = SUNEDITOR.create((document.getElementById('meContainer') || 'meContainer'), {
        // All of the plugins are loaded in the "window.SUNEDITOR" object in dist/suneditor.min.js file
        // Insert options
        // Language global object (default: en)
        buttonList: [
            [
                'font',
                'bold', 'italic', 'underline', 'strike', 'fontSize',
                'fontColor', 'hiliteColor', 'subscript', 'superscript', 'list', 'textStyle',
                'indent', 'align', 'link', 'image'

            ],
        ],
        lineHeights: [
            { text: '1', value: 1 },
        ],
        fontSize: [
            8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 34, 36, 48, 72
        ],
        position: 'fixed',
        width: '100%',
        height: '100%',
        defaultStyle: 'font-family: Calibri; sans-seri;'
    });
    const wrapper = document.getElementsByClassName('se-wrapper');
    for (var i = 0; i < wrapper.length; i++) {
        wrapper[i].style.height = '100%';
    }
}