function(doc) {
  if (doc.document_type == 'Transaction')
    emit(null, doc);
}
