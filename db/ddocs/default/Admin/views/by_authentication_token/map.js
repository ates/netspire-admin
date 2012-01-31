function(doc) {
  if (doc.document_type == 'Admin')
    emit(doc.authentication_token, doc);
}
