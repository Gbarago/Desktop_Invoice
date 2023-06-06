import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import '../../models/invoice_model.dart';

class InvoiceController extends GetxController {
  Dummy dat = Dummy();
  List<Invoice> invoices = [];
  List<Invoice> newInvoiceList = [];
  double totalPrice = 0;
  // updated list after editing or deleting an invoice
  List<Item>? items = [];
  String status = '';
  bool isDelete = false;
  Future<void> fetchData() async {
    // fetch initial data to populate app

    if (newInvoiceList.isEmpty && !isDelete) {
      // check if the new list has been populated
      var initialData = dat.jsonData;

      List<dynamic> invoicesList = jsonDecode(initialData);

      for (var data in invoicesList) {
        Invoice invoice = Invoice.fromJson(data);
        invoices.add(invoice);
      }
    }
  }

//delete an invoice
  void deleteInvoice(Invoice invoice) {
    invoices.remove(invoice);
    newInvoiceList = invoices; // update invoice list after deleting
    isDelete = true;
    update();
  }

// generate unique ID for invoice
  String generateInvoiceId() {
    final random = Random();
    final letters =
        List.generate(2, (_) => String.fromCharCode(random.nextInt(26) + 65));
    final numbers = List.generate(4, (_) => random.nextInt(10).toString());
    return '${letters.join('')}${numbers.join('')}';
  }

// add an item to the list
  void addItem(String name, int quantity, double price) {
    if (items == null) {
      items = [];
    }

    double total = quantity * price;
    Item newItem =
        Item(name: name, quantity: quantity, price: price, total: total);
    items!.add(newItem);

    totalPrice = calculateTotalPrice(); // Recalculate the total priceupdate();
  }

//remove an item froom the list
  void removeItem(Item item) {
    if (items == null) {
      items = [];
    }

    items!.remove(item);

    totalPrice = calculateTotalPrice(); // Recalculate the total price
    update();
  }

//clear ITEM LIST after ordeer has been mde ore discarded
  clearItems() {
    items?.clear();
    update();
  }

//create invoice
  void createInvoice(Invoice invoice) {
    invoice.id = generateInvoiceId();
    invoices.add(invoice);

    newInvoiceList = invoices; // update invoice list after deleting
    update();
  }

//calculte the totalvalue oof invoice items
  double calculateTotalPrice() {
    double totalPrice = 0;
    if (items != null) {
      for (Item item in items!) {
        totalPrice += item.total ?? 0;
      }
    }
    return totalPrice;
  }
}
