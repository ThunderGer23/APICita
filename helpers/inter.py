def interpretacion_cita ( ref ):
  interprete = []
  for cita in ref:
    if cita >=0.5 :
      interprete.append('CITA APA')
    elif len(cita)< 25:
      interprete.append('CITA Erronea')
    else:
      interprete.append('CITA IEEE')
  return interprete