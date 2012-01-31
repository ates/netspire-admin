function(doc) {
  if (doc.document_type == 'ServiceLink')
    emit([doc.account, doc.service], doc);
}
