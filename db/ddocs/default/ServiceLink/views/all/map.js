function(doc) {
  if (doc.document_type == 'ServiceLink')
    emit(null, doc);
}
