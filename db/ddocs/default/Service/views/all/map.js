function(doc) {
  if (doc.document_type == 'Service')
    emit(null, doc);
}
