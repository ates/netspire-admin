function(doc) {
  if (doc.document_type == 'Account')
    emit(doc.login, doc);
}
