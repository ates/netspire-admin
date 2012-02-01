function(doc) {
  if (doc.document_type == 'ServiceLink')
    emit([doc.login, doc.service], doc);
}
