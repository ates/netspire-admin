function(doc) {
  if (doc.document_type == 'Transaction')
    emit(doc.account, doc);
}
