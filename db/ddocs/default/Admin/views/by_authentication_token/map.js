function(doc) {
  if (doc.document_type == 'Admin' && doc.active == true)
    emit(doc.authentication_token, doc);
}
