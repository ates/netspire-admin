function(doc) {
  if (doc.document_type == 'Transaction') {
    var amount = (doc.code == 1) ? doc.amount * -1 : doc.amount;
    emit(doc.account, amount);
  }
}
