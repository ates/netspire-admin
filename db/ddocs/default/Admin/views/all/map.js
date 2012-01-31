function(doc) {
  if (doc.document_type == 'Admin')
    emit(null, doc);
}
