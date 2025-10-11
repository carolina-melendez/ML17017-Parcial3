USE DWVuelos;

INSERT INTO dim.DimCausa (Codigo,Descripcion,Tipo) VALUES
('A','Retraso por Aerolínea','Retraso'),
('B','Retraso por Clima','Retraso'),
('C','Retraso por Sistema Aéreo (NAS)','Retraso'),
('D','Retraso por Seguridad','Retraso'),
('L','Retraso por Aeronave Previa','Retraso'),
('X','Vuelo Cancelado','Cancelación'),
('N','A Tiempo / Sin Retraso','Normal');