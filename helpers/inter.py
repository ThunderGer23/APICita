def interpretacion_cita ( ref ):
  interprete = []
  for cita in ref:
    if cita >=0.5 :
      interprete.append('CITA APA')
    else:
      interprete.append('CITA IEEE')
  return interprete