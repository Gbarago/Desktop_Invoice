import 'package:boya_invoices/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class FormFieldWidgets extends StatelessWidget {
  FormFieldWidgets(
      {super.key,
      required this.conttroller,
      required this.title,
      this.keyBooardType,
      this.isNumberOnly});
  final TextEditingController conttroller;
  final String title;
  TextInputType? keyBooardType;
  bool? isNumberOnly;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white54),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, top: 0),
          ),
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.white, fontSize: 12),
              controller: conttroller,
              inputFormatters: isNumberOnly == true
                  ? [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ]
                  : null,
              keyboardType: keyBooardType ?? TextInputType.name,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20, bottom: 20),
                  labelText: '',
                  filled: true,
                  border: InputBorder.none, // Remove input border

                  fillColor: AppColors.priimaryFillColor),
            ),
          )
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons(
      {super.key,
      required this.title,
      required this.butttonColor,
      required this.onPressed,
      this.textColor,
      required this.buttoniWdth,
      required this.hoverColor});
  final String title;
  final Color butttonColor;
  final Color hoverColor;

  final Color? textColor;
  final double buttoniWdth;

  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      height: 40,
      width: buttoniWdth,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: Builder(builder: (BuildContext context) {
        return MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          color: butttonColor,
          hoverColor: hoverColor,
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: textColor ?? Colors.white,
            ),
          ),
        );
      }),
    );
  }
}

class CustDropDown<T> extends StatefulWidget {
  final List<CustDropdownMenuItem> items;
  final Function onChanged;
  final String hintText;
  final double borderRadius;
  final double maxListHeight;
  final double borderWidth;
  final int defaultSelectedIndex;
  final bool enabled;
  final EdgeInsetsGeometry? margin;

  const CustDropDown(
      {required this.items,
      required this.onChanged,
      this.hintText = "",
      this.borderRadius = 0,
      this.borderWidth = 1,
      this.maxListHeight = 100,
      this.defaultSelectedIndex = -1,
      Key? key,
      this.enabled = true,
      this.margin})
      : super(key: key);

  @override
  _CustDropDownState createState() => _CustDropDownState();
}

class _CustDropDownState extends State<CustDropDown>
    with WidgetsBindingObserver {
  bool _isOpen = false, _isAnyItemSelected = false, _isReverse = false;
  late OverlayEntry _overlayEntry;
  late RenderBox? _renderBox;
  Widget? _itemSelected;
  late Offset dropDownOffset;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          dropDownOffset = getOffset();
        });
      }
      if (widget.defaultSelectedIndex > -1) {
        if (widget.defaultSelectedIndex < widget.items.length) {
          if (mounted) {
            setState(() {
              _isAnyItemSelected = true;
              _itemSelected = widget.items[widget.defaultSelectedIndex];
              widget.onChanged(widget.items[widget.defaultSelectedIndex].value);
            });
          }
        }
      }
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void _addOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = true;
      });
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
  }

  void _removeOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
      _overlayEntry.remove();
    }
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    _renderBox = context.findRenderObject() as RenderBox?;
    //final theme = Theme.of(context);

    var size = _renderBox!.size;

    dropDownOffset = getOffset();

    return OverlayEntry(
        maintainState: false,
        builder: (context) => Align(
              alignment: Alignment.center,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: dropDownOffset,
                child: Container(
                  margin: widget.margin,
                  color: AppColors.priimaryFillColor,
                  height: widget.maxListHeight,
                  width: size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: _isReverse
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          constraints: BoxConstraints(
                              maxHeight: widget.maxListHeight,
                              maxWidth: size.width),
                          decoration: BoxDecoration(
                              // color: Colors.yellow,
                              // color: AppColors.primary_blue.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(5)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(widget.borderRadius),
                            ),
                            child: Material(
                              color: AppColors.priimaryFillColor,
                              elevation: 0,
                              shadowColor: Colors.grey,
                              child: ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                children: widget.items
                                    .map((item) => GestureDetector(
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: item.child,
                                          ),
                                          onTap: () {
                                            if (mounted) {
                                              setState(() {
                                                _isAnyItemSelected = true;
                                                _itemSelected = item.child;
                                                _removeOverlay();
                                                if (widget.onChanged != null)
                                                  widget.onChanged(item.value);
                                              });
                                            }
                                          },
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Offset getOffset() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    double y = renderBox!.localToGlobal(Offset.zero).dy;
    double spaceAvailable = _getAvailableSpace(y + renderBox.size.height);
    if (spaceAvailable > widget.maxListHeight) {
      _isReverse = false;
      return Offset(0, renderBox.size.height);
    } else {
      _isReverse = true;
      return Offset(
          0,
          renderBox.size.height -
              (widget.maxListHeight + renderBox.size.height));
    }
  }

  double _getAvailableSpace(double offsetY) {
    double safePaddingTop = MediaQuery.of(context).padding.top;
    double safePaddingBottom = MediaQuery.of(context).padding.bottom;

    double screenHeight =
        MediaQuery.of(context).size.height - safePaddingBottom - safePaddingTop;

    return screenHeight - offsetY;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.enabled
            ? () {
                _isOpen ? _removeOverlay() : _addOverlay();
              }
            : null,
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: AppColors.priimaryFillColor,
            ),
            color: AppColors.priimaryFillColor,
          ),

          //  decoration: _getDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: _isAnyItemSelected
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                        ),
                        child: _itemSelected!,
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(left: 4.0), // change it here
                        child: Text(
                          widget.hintText,
                          style: const TextStyle(
                              color: Color(0xff828282),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: "sf-ui-display"),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
              ),
              Flexible(
                flex: 1,
                child: Icon(
                  !_isOpen
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: AppColors.addButtonColor,
                  // Color(0xff0A14AC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Decoration? _getDecoration() {
    if (_isOpen && !_isReverse) {
      return BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.borderRadius),
              topRight: Radius.circular(
                widget.borderRadius,
              )));
    } else if (_isOpen && _isReverse) {
      return BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(widget.borderRadius),
              bottomRight: Radius.circular(
                widget.borderRadius,
              )));
    } else if (!_isOpen) {
      return BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)));
    }
  }
}

class CustDropdownMenuItem<T> extends StatelessWidget {
  final T value;
  final Widget child;

  const CustDropdownMenuItem({required this.value, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
