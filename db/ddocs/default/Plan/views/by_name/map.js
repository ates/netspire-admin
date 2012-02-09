function(doc) {
  if (doc.document_type == 'Plan')
    emit(doc.name, doc);
}
