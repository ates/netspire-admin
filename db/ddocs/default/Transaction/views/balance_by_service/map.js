function(doc) {
  if (doc.document_type == 'Transaction' && doc.service != null) {
    var amount = (doc.code == 1) ? doc.amount * -1 : doc.amount;
    emit([doc.account, doc.service], amount);
  }
}
