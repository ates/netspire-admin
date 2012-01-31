function(doc) {
  if (doc.document_type == 'Transaction' && doc.service != null)
    emit([doc.account, doc.service], doc.amount);
}
