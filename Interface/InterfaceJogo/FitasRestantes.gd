extends Label

func atualizar_fitas_restantes(quantidade: int):
	var restante = "0"+str(quantidade) if quantidade < 10 else str(quantidade) 
	var total = "0"+str(Globais.quantidade_fitas) if Globais.quantidade_fitas < 10 else str(Globais.quantidade_fitas) 
	
	text = restante+"/"+total
