function(doc) {
  if (doc.document_type == 'Admin')
    emit(doc.login, doc);
}
