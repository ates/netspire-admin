function(doc) {
  if (doc.document_type == 'RadiusAttribute')
    emit(null, doc);
}
