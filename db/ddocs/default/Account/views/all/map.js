function(doc) {
  if (doc.document_type == 'Account')
    emit(null, doc);
}
