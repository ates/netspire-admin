function(doc) {
  if (doc.document_type == 'Plan')
    emit(null, doc);
}
