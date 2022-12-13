# User
User.create!(name: 'Usuário Regular 1', email: 'regular1@sistemadefrete.com.br', password: 'password',
             access_group: :regular)
User.create!(name: 'Usuário Admin 1', email: 'admin1@sistemadefrete.com.br', password: 'password', access_group: :admin)

# Transportation Modal
transportationmodal1 = TransportationModal.create!(name: 'Bicicleta', max_distance: 10, min_distance: 0,
                                                   max_weight: 10, min_weight: 0, flat_rate: 5, status: :active)
transportationmodal2 = TransportationModal.create!(name: 'Motocicleta', max_distance: 60, min_distance: 10,
                                                   max_weight: 30, min_weight: 0, flat_rate: 10, status: :active)
transportationmodal3 = TransportationModal.create!(name: 'Avião', max_distance: 5000, min_distance: 250,
                                                   max_weight: 5_000_000, min_weight: 500, flat_rate: 100,
                                                   status: :active)
TransportationModal.create!(name: 'Van', max_distance: 400, min_distance: 0,
                            max_weight: 1200, min_weight: 5, flat_rate: 25, status: :active)

# Vehicle
Vehicle.create!(license_plate: 'HUIK-5232', model: 'City Tour', brand: 'Caloi', max_weight: '5',
                manufacture_year: '2015', transportation_modal: transportationmodal1, status: :active)
Vehicle.create!(license_plate: 'HHDU-8946', model: 'GTS', brand: 'Shimano', max_weight: '7',
                manufacture_year: '2017', transportation_modal: transportationmodal1, status: :maintenance)
Vehicle.create!(license_plate: 'OSP-7854', model: 'NC750X', brand: 'Honda', max_weight: '16',
                manufacture_year: '2021', transportation_modal: transportationmodal2, status: :maintenance)
Vehicle.create!(license_plate: 'GHR-7523', model: 'Tiger 660', brand: 'Triumph', max_weight: '50',
                manufacture_year: '2019', transportation_modal: transportationmodal2, status: :active)
Vehicle.create!(license_plate: 'PHF-3168', model: 'Z650', brand: 'Kawasaki', max_weight: '25',
                manufacture_year: '2018', transportation_modal: transportationmodal2, status: :active)
Vehicle.create!(license_plate: 'AGSY-1249', model: 'A340', brand: 'Airbus', max_weight: '800000',
                manufacture_year: '2018', transportation_modal: transportationmodal3, status: :active)

# Timescale
Timescale.create!(min_distance: 0, max_distance: 10, deadline: 24, transportation_modal: transportationmodal1)
Timescale.create!(min_distance: 10, max_distance: 20, deadline: 24, transportation_modal: transportationmodal2)
Timescale.create!(min_distance: 21, max_distance: 40, deadline: 48, transportation_modal: transportationmodal2)
Timescale.create!(min_distance: 41, max_distance: 60, deadline: 96, transportation_modal: transportationmodal2)
Timescale.create!(min_distance: 250, max_distance: 1000, deadline: 48, transportation_modal: transportationmodal4)
Timescale.create!(min_distance: 1001, max_distance: 5000, deadline: 96, transportation_modal: transportationmodal4)

# Cost
Cost.create!(category: :weight, minimum: 500, maximum: 2000, unit_price: 15,
             transportation_modal: transportationmodal4)
Cost.create!(category: :weight, minimum: 2001, maximum: 50_000, unit_price: 25,
             transportation_modal: transportationmodal4)
Cost.create!(category: :weight, minimum: 50_001, maximum: 500_000, unit_price: 40,
             transportation_modal: transportationmodal4)
Cost.create!(category: :weight, minimum: 0, maximum: 10, unit_price: 1, transportation_modal: transportationmodal1)
Cost.create!(category: :weight, minimum: 0, maximum: 10, unit_price: 2, transportation_modal: transportationmodal2)
Cost.create!(category: :weight, minimum: 10, maximum: 30, unit_price: 3, transportation_modal: transportationmodal2)
Cost.create!(category: :distance, minimum: 250, maximum: 4000, unit_price: 75,
             transportation_modal: transportationmodal4)
Cost.create!(category: :distance, minimum: 0, maximum: 10, unit_price: 2, transportation_modal: transportationmodal1)
Cost.create!(category: :distance, minimum: 10, maximum: 20, unit_price: 7, transportation_modal: transportationmodal2)
Cost.create!(category: :distance, minimum: 21, maximum: 60, unit_price: 17,
             transportation_modal: transportationmodal2)

# Service Order
ServiceOrder.create!(pickup_address: 'R. Iacanga, 49 - Vila Joao Jorge, Campinas - SP, 13041-309',
                     product_code: 'CX124060', weight: 5, width: 20, height: 40, depth: 50,
                     recipient_name: 'Maria Carvalho',
                     recipient_address: 'R. Uruguaiana, 265 - Bosque, Campinas - SP, 13026-000',
                     recipient_phone: '019985463251', distance: 7)
ServiceOrder.create!(pickup_address: 'R. França, 539 - Jardim Europa, São Paulo - SP, 01446-010',
                     product_code: 'CX752169', weight: 15, width: 50, height: 70, depth: 70,
                     recipient_name: 'Francisco Quintal',
                     recipient_address: 'R. Sebastião Walter Fusco, 309 - Cidade Soinco, Guarulhos - SP, 07182-230',
                     recipient_phone: '011987523648', distance: 30)
ServiceOrder.create!(pickup_address: 'R. Silveira Neto, 144 - Água Verde, Curitiba - PR, 80620-410',
                     product_code: 'PPS85', weight: 1000, width: 1200, height: 2000, depth: 1100,
                     recipient_name: 'Izabel Alves',
                     recipient_address: 'R. Fernão Sales, 416 - Vila Hortência, Sorocaba - SP, 18020-266',
                     recipient_phone: '015975485638', distance: 300)
