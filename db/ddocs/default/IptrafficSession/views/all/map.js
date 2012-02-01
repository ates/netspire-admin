function(doc) {
  if (doc.document_type == 'IptrafficSession')
    emit(null, doc);
}
