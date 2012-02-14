function(doc) {
  if (doc.document_type == 'Service')
    emit(doc.name, doc);
}
