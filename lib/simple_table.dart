import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:telemetry/constant.dart';

class SimpleTablePage extends StatefulWidget {
  const SimpleTablePage({
    Key? key,
    required this.data,
    required this.titleColumn,
    required this.titleRow,
  }) : super(key: key);

  final List<List<String>> data;
  final List<String> titleColumn;
  final List<String> titleRow;

  @override
  State<SimpleTablePage> createState() => _SimpleTablePageState();
}

class _SimpleTablePageState extends State<SimpleTablePage> {
  @override
  Widget build(BuildContext context) {
    return StickyHeadersTable(
      columnsLength: widget.titleColumn.length,
      rowsLength: widget.titleRow.length,
      columnsTitleBuilder: (i) => TableCell.stickyRow(widget.titleColumn[i],
          textStyle: Constant.tableHeader),
      rowsTitleBuilder: (i) => TableCell.legend(
        widget.titleRow[i],
        textStyle: Constant.tableHeader,
      ),
      contentCellBuilder: (i, j) => TableCell.stickydata(
        widget.data[i][j] != null ? widget.data[i][j] : '',
      ),
      legendCell: TableCell.legend(
        'Station',
        textStyle: Constant.tableHeader,
      ),
      showVerticalScrollbar: true,
      showHorizontalScrollbar: true,
    );
  }
}

class TableCell extends StatelessWidget {
  TableCell.legend(
    this.text, {
    Key? key,
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = const Color(0XFF0f0f68),
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = const Color(0XFF0f0f68),
        _colorVerticalBorder = const Color(0XFF0f0f68),
        _textAlign = TextAlign.start,
        _padding = const EdgeInsets.symmetric(horizontal: 8.0),
        super(key: key);

  TableCell.stickyRow(
    this.text, {
    Key? key,
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = const Color(0XFF0f0f68),
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = const Color(0XFF0f0f68),
        _colorVerticalBorder = const Color(0XFF0f0f68),
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero,
        super(key: key);

  TableCell.stickyColumn(
    this.text, {
    Key? key,
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = const Color(0XFF0f0f68),
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = const Color(0XFF0f0f68),
        _colorVerticalBorder = const Color(0XFF0f0f68),
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero,
        super(key: key);

  TableCell.stickydata(
    this.text, {
    Key? key,
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = const Color(0XFFFFFFFF),
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = const Color(0XFFFFFFFF),
        _colorVerticalBorder = Colors.grey,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero,
        super(key: key);

  final CellDimensions cellDimensions;

  final String text;
  final Function()? onTap;

  final double? cellWidth;
  final double? cellHeight;

  final Color colorBg;
  final Color _colorHorizontalBorder;
  final Color _colorVerticalBorder;

  final TextAlign _textAlign;
  final EdgeInsets _padding;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cellWidth,
        height: cellHeight,
        padding: _padding,
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: _colorHorizontalBorder),
              right: BorderSide(color: _colorHorizontalBorder),
            ),
            color: colorBg),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  text,
                  style: textStyle,
                  maxLines: 2,
                  textAlign: _textAlign,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.1,
              color: _colorVerticalBorder,
            ),
          ],
        ),
      ),
    );
  }
}
