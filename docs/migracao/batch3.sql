BEGIN;

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('27f570e8-f1e7-4e4f-8d5b-b179c9ec31a0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Compra 06 cabecas de carregadores', 'f4e2e4ab-c5aa-429f-9336-6f6b2774a3f4', 143.58, '2026-04-22', 'paid', '2026-04-22', 143.58, 'Pago - Comprovante - compra de 06 cabeças de carregadores.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('4af4bfb4-7346-4eda-b61c-58bd146d24e5', 'e11042be-3d22-4048-9380-ac71e8dc9252', '27f570e8-f1e7-4e4f-8d5b-b179c9ec31a0', 143.58, '2026-04-22', 'Pago - Comprovante - compra de 06 cabeças de carregadores.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('a606c1ec-0b72-404b-8ea4-8b466fa09bf1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 143.58, '2026-04-22', 'Compra 06 cabecas de carregadores', '27f570e8-f1e7-4e4f-8d5b-b179c9ec31a0', '4af4bfb4-7346-4eda-b61c-58bd146d24e5', 'Cartão', 'Pago - Comprovante - compra de 06 cabeças de carregadores.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('b0bad1b8-5fd8-4e9a-aa6f-91c2655380b9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Bella Aldeota e Bella Rio', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-04-23', 'paid', '2026-04-23', 1000, 'Pago - Saldo Campanha - Bella Aldeota e Bella Rio.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('8f712b62-f92e-43fc-a2d2-243ac31fe044', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'b0bad1b8-5fd8-4e9a-aa6f-91c2655380b9', 1000, '2026-04-23', 'Pago - Saldo Campanha - Bella Aldeota e Bella Rio.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('6e21ff8c-43ea-4b76-bee2-82868a6fe067', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-04-23', 'Saldo Meta — Bella Aldeota e Bella Rio', 'b0bad1b8-5fd8-4e9a-aa6f-91c2655380b9', '8f712b62-f92e-43fc-a2d2-243ac31fe044', 'Pix', 'Pago - Saldo Campanha - Bella Aldeota e Bella Rio.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('bc841f22-b68a-48d8-882c-62b2bc4cb835', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — BSWave e Maré', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 750, '2026-04-23', 'paid', '2026-04-23', 750, 'Pago - Saldo Campanha - BS Wave e Mare.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('9459184d-b84e-4c4a-bd73-981aee2e84a1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'bc841f22-b68a-48d8-882c-62b2bc4cb835', 750, '2026-04-23', 'Pago - Saldo Campanha - BS Wave e Mare.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('0cda4c94-c7bb-48ca-9ada-53d370384334', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 750, '2026-04-23', 'Saldo Meta — BSWave e Maré', 'bc841f22-b68a-48d8-882c-62b2bc4cb835', '9459184d-b84e-4c4a-bd73-981aee2e84a1', 'Pix', 'Pago - Saldo Campanha - BS Wave e Mare.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('5ff87263-0347-4e64-8717-fa8574186da5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — MLar Cambeba e Lago', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 750, '2026-04-23', 'paid', '2026-04-23', 750, 'Pago - Saldo Campanha - MLar Cambeba e Lago.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('70f3af17-fa0a-441d-8b10-d0a463b2842b', 'e11042be-3d22-4048-9380-ac71e8dc9252', '5ff87263-0347-4e64-8717-fa8574186da5', 750, '2026-04-23', 'Pago - Saldo Campanha - MLar Cambeba e Lago.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('a810fa60-5c31-4e96-aec1-d034f6cdd4dc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 750, '2026-04-23', 'Saldo Meta — MLar Cambeba e Lago', '5ff87263-0347-4e64-8717-fa8574186da5', '70f3af17-fa0a-441d-8b10-d0a463b2842b', 'Pix', 'Pago - Saldo Campanha - MLar Cambeba e Lago.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('5232ac52-0fb5-490c-a663-efffcf0e2fbb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google — GAds Internacional', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 400, '2026-04-23', 'paid', '2026-04-23', 400, 'Pago - Saldo Campanha - GAds Internacional.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('cc2f4aa7-e3dc-43af-9f06-47d7c49306bb', 'e11042be-3d22-4048-9380-ac71e8dc9252', '5232ac52-0fb5-490c-a663-efffcf0e2fbb', 400, '2026-04-23', 'Pago - Saldo Campanha - GAds Internacional.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('b8de4c0c-3cdb-4966-afaf-83a752a69739', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-04-23', 'Saldo Google — GAds Internacional', '5232ac52-0fb5-490c-a663-efffcf0e2fbb', 'cc2f4aa7-e3dc-43af-9f06-47d7c49306bb', 'Pix', 'Pago - Saldo Campanha - GAds Internacional.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('bdab7d16-f02b-4939-9b41-4bff4ce1b01f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Compra 08 cabos carregadores + Régua', 'f4e2e4ab-c5aa-429f-9336-6f6b2774a3f4', 138.03, '2026-04-23', 'paid', '2026-04-23', 138.03, '');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('a0ceb101-4605-4630-b055-e6249e6502f0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'bdab7d16-f02b-4939-9b41-4bff4ce1b01f', 138.03, '2026-04-23', '');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('cc69f96d-e72e-4ccf-9361-ea4b6a32a64e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 138.03, '2026-04-23', 'Compra 08 cabos carregadores + Régua', 'bdab7d16-f02b-4939-9b41-4bff4ce1b01f', 'a0ceb101-4605-4630-b055-e6249e6502f0', 'Cartão', '');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('9e5afac2-42fd-4fa9-9dbc-38ae99adf7f0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Compra 10 suportes de celulares', '2a1ede6d-1df1-4ee5-8e36-b4782683da26', 41.12, '2026-04-24', 'paid', '2026-04-24', 41.12, '10 suportes de celulares.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5ca237d0-ca02-4621-8966-527a95194b5f', 'e11042be-3d22-4048-9380-ac71e8dc9252', '9e5afac2-42fd-4fa9-9dbc-38ae99adf7f0', 41.12, '2026-04-24', '10 suportes de celulares.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('0c4de8ad-34b9-4230-9929-5eee20247504', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 41.12, '2026-04-24', 'Compra 10 suportes de celulares', '9e5afac2-42fd-4fa9-9dbc-38ae99adf7f0', '5ca237d0-ca02-4621-8966-527a95194b5f', 'Cartão', '10 suportes de celulares.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('f9c073c6-28e7-4ba2-958e-3f089d389bbd', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google — GAds Fortaleza RE9 Imob', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 1000, '2026-04-27', 'paid', '2026-04-27', 1000, 'Pago - Saldo Campanha - GAds Fortaleza.png');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('27cdb44c-ebc5-4cb3-95d0-438edf63f23c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'f9c073c6-28e7-4ba2-958e-3f089d389bbd', 1000, '2026-04-27', 'Pago - Saldo Campanha - GAds Fortaleza.png');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('a5444362-996e-42d8-93a0-febd6371f08a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-04-27', 'Saldo Google — GAds Fortaleza RE9 Imob', 'f9c073c6-28e7-4ba2-958e-3f089d389bbd', '27cdb44c-ebc5-4cb3-95d0-438edf63f23c', 'Pix', 'Pago - Saldo Campanha - GAds Fortaleza.png');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('aa755013-0604-4fab-a6c8-a7124bf9c28c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — MLar Cambeba e Lago', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 500, '2026-04-27', 'paid', '2026-04-27', 500, 'Pago - Saldo Campanha - Meta MLar Cambeba e Lago.png');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d95132c9-5244-46f1-ad7b-4404ee3751ca', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'aa755013-0604-4fab-a6c8-a7124bf9c28c', 500, '2026-04-27', 'Pago - Saldo Campanha - Meta MLar Cambeba e Lago.png');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('99f7c2b4-aaac-4612-8ed1-0e222af50196', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-04-27', 'Saldo Meta — MLar Cambeba e Lago', 'aa755013-0604-4fab-a6c8-a7124bf9c28c', 'd95132c9-5244-46f1-ad7b-4404ee3751ca', 'Pix', 'Pago - Saldo Campanha - Meta MLar Cambeba e Lago.png');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('22eac0e4-fd2b-4521-aa4b-1ba545fca8d3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Atlântico, Orizon e Seano', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 500, '2026-05-02', 'paid', '2026-05-02', 500, 'Pago - Saldo Meta - AtlanticoSeanoOrizon - Maio26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('66a16ef6-42c2-4777-b17a-f750e7110f75', 'e11042be-3d22-4048-9380-ac71e8dc9252', '22eac0e4-fd2b-4521-aa4b-1ba545fca8d3', 500, '2026-05-02', 'Pago - Saldo Meta - AtlanticoSeanoOrizon - Maio26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('47d92097-4e43-47c0-95d2-4ef098f54e21', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-02', 'Saldo Meta — Atlântico, Orizon e Seano', '22eac0e4-fd2b-4521-aa4b-1ba545fca8d3', '66a16ef6-42c2-4777-b17a-f750e7110f75', 'Cartão', 'Pago - Saldo Meta - AtlanticoSeanoOrizon - Maio26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('a5358ffa-7749-4ebc-b9c2-ed3abbb31863', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Bella Aldeota e Bella Rio', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-05-02', 'paid', '2026-05-02', 1000, 'Pago - Saldo Meta - Bella Aldeota e Bella Rio - Maio26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('ef1b6dd9-a415-4589-a592-81b9e5ea1e59', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'a5358ffa-7749-4ebc-b9c2-ed3abbb31863', 1000, '2026-05-02', 'Pago - Saldo Meta - Bella Aldeota e Bella Rio - Maio26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('ce1c8f22-82a4-4683-b880-c78c61aecff9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-02', 'Saldo Meta — Bella Aldeota e Bella Rio', 'a5358ffa-7749-4ebc-b9c2-ed3abbb31863', 'ef1b6dd9-a415-4589-a592-81b9e5ea1e59', 'Cartão', 'Pago - Saldo Meta - Bella Aldeota e Bella Rio - Maio26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('f9774732-2494-4953-b233-568e90de54e5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — BSWave e Maré', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 400, '2026-05-02', 'paid', '2026-05-02', 400, 'Pago - Saldo Meta - BSWave e Mare - Maio26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('650d539e-f064-4281-b6e9-8308bb115b0a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'f9774732-2494-4953-b233-568e90de54e5', 400, '2026-05-02', 'Pago - Saldo Meta - BSWave e Mare - Maio26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('fe24ac65-ca68-4ccf-9b73-391ee9ee7917', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-05-02', 'Saldo Meta — BSWave e Maré', 'f9774732-2494-4953-b233-568e90de54e5', '650d539e-f064-4281-b6e9-8308bb115b0a', 'Cartão', 'Pago - Saldo Meta - BSWave e Mare - Maio26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('731adc5f-767d-4c9c-9c44-e091e1d367e5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — MLar Cambeba e Lago', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 400, '2026-05-02', 'paid', '2026-05-02', 400, 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('e34a0de5-d425-43aa-9cd0-b76d2a073e7b', 'e11042be-3d22-4048-9380-ac71e8dc9252', '731adc5f-767d-4c9c-9c44-e091e1d367e5', 400, '2026-05-02', 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('ccaacc8e-d597-45e3-a123-a334449ac117', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-05-02', 'Saldo Meta — MLar Cambeba e Lago', '731adc5f-767d-4c9c-9c44-e091e1d367e5', 'e34a0de5-d425-43aa-9cd0-b76d2a073e7b', 'Cartão', 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ee71c441-2462-4293-bc63-0ee04a19fe89', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pagamento Comissão Corretor Reno — Vibe 2103', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 12003.21, '2026-05-05', 'paid', '2026-05-05', 12003.21, 'Pago - Comissão Reno - Vibe Meireles Ap2103.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('a30c0c61-8bfb-4836-b8b7-324c14a71e18', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ee71c441-2462-4293-bc63-0ee04a19fe89', 12003.21, '2026-05-05', 'Pago - Comissão Reno - Vibe Meireles Ap2103.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('bf769bf4-6c0d-448b-a8a3-49cb0fa8c46a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 12003.21, '2026-05-05', 'Pagamento Comissão Corretor Reno — Vibe 2103', 'ee71c441-2462-4293-bc63-0ee04a19fe89', 'a30c0c61-8bfb-4836-b8b7-324c14a71e18', 'Pix', 'Pago - Comissão Reno - Vibe Meireles Ap2103.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('8a62d4fa-308a-450c-9ff5-e46e547a78dc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pagamento Angélica — Vibe Meireles 2103', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 500, '2026-05-05', 'paid', '2026-05-05', 500, 'Pago - Comissao1 Angelica Mai26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('e21f5a3c-732e-4eb5-b45d-3bf1d13200b1', 'e11042be-3d22-4048-9380-ac71e8dc9252', '8a62d4fa-308a-450c-9ff5-e46e547a78dc', 500, '2026-05-05', 'Pago - Comissao1 Angelica Mai26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('2c09d6c2-0d81-4a9d-8b30-1a281f3dbd21', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-05', 'Pagamento Angélica — Vibe Meireles 2103', '8a62d4fa-308a-450c-9ff5-e46e547a78dc', 'e21f5a3c-732e-4eb5-b45d-3bf1d13200b1', 'Pix', 'Pago - Comissao1 Angelica Mai26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('13edb0b4-8431-4778-8aae-0d8861692061', 'e11042be-3d22-4048-9380-ac71e8dc9252', '50% Placas Porta RE9 — CEPlacas', 'f8d56c53-a2a4-41c2-9372-7c9560332cf4', 375, '2026-05-05', 'paid', '2026-05-05', 375, 'Pago - Placas RE9 pt1.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('4deb8b23-f5bf-4192-86d0-76c2c0488a48', 'e11042be-3d22-4048-9380-ac71e8dc9252', '13edb0b4-8431-4778-8aae-0d8861692061', 375, '2026-05-05', 'Pago - Placas RE9 pt1.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('815a197f-e924-436c-9fca-80dbf05682bc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 375, '2026-05-05', '50% Placas Porta RE9 — CEPlacas', '13edb0b4-8431-4778-8aae-0d8861692061', '4deb8b23-f5bf-4192-86d0-76c2c0488a48', 'Pix', 'Pago - Placas RE9 pt1.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ab81f52b-d50e-4b38-a055-16f89483dac9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Atlântico, Orizon e Seano', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 2652.04, '2026-05-07', 'paid', '2026-05-07', 2652.04, 'Pago - Saldo Meta - AtlanticoSeanoOrizon 2 - Maio26.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('7b029ea1-85d9-4729-812e-28c4c1defd2f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ab81f52b-d50e-4b38-a055-16f89483dac9', 2652.04, '2026-05-07', 'Pago - Saldo Meta - AtlanticoSeanoOrizon 2 - Maio26.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('0548d38c-fbb3-4428-bb7a-c88fa18a6cd8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2652.04, '2026-05-07', 'Saldo Meta — Atlântico, Orizon e Seano', 'ab81f52b-d50e-4b38-a055-16f89483dac9', '7b029ea1-85d9-4729-812e-28c4c1defd2f', 'Pix', 'Pago - Saldo Meta - AtlanticoSeanoOrizon 2 - Maio26.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('3b7e7b98-18ce-485c-a9ab-fea343bcbb9c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Bella Aldeota e Bella Rio', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 2000, '2026-05-07', 'paid', '2026-05-07', 2000, 'Pago - Saldo Meta - BellaAldeota e Bella Rio 2 - Maio26.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('260ad406-59e8-4bdf-af2a-cd6de9db81ae', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3b7e7b98-18ce-485c-a9ab-fea343bcbb9c', 2000, '2026-05-07', 'Pago - Saldo Meta - BellaAldeota e Bella Rio 2 - Maio26.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('696b392b-5e81-4f76-892b-cce23f732bce', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2000, '2026-05-07', 'Saldo Meta — Bella Aldeota e Bella Rio', '3b7e7b98-18ce-485c-a9ab-fea343bcbb9c', '260ad406-59e8-4bdf-af2a-cd6de9db81ae', 'Pix', 'Pago - Saldo Meta - BellaAldeota e Bella Rio 2 - Maio26.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('6c553cf8-9702-40ce-bccb-2ae77c1c602d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Curso para Corretores — CFCI', '96a253df-5a0e-4185-9969-c2dee94de1a5', 485, '2026-05-08', 'paid', '2026-05-08', 485, 'Pago - Curso para Corretores.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('ba557683-ed66-4c06-a7a8-69147f751b75', 'e11042be-3d22-4048-9380-ac71e8dc9252', '6c553cf8-9702-40ce-bccb-2ae77c1c602d', 485, '2026-05-08', 'Pago - Curso para Corretores.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('a4c52599-f44c-4a4c-b669-eac378aeece7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 485, '2026-05-08', 'Curso para Corretores — CFCI', '6c553cf8-9702-40ce-bccb-2ae77c1c602d', 'ba557683-ed66-4c06-a7a8-69147f751b75', 'Pix', 'Pago - Curso para Corretores.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ea9e56e2-4926-4616-834e-218373889f70', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Jsmart e Diagonal', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1139, '2026-05-08', 'paid', '2026-05-08', 1139, 'Pago - Saldo Meta - Jsmart e Diagonal.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('7adbd86b-bc0b-4c0d-ab9c-6b5219452744', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ea9e56e2-4926-4616-834e-218373889f70', 1139, '2026-05-08', 'Pago - Saldo Meta - Jsmart e Diagonal.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('9393f632-0484-4a35-948a-a97292f7407d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-08', 'Saldo Meta — Jsmart e Diagonal', 'ea9e56e2-4926-4616-834e-218373889f70', '7adbd86b-bc0b-4c0d-ab9c-6b5219452744', 'Pix', 'Pago - Saldo Meta - Jsmart e Diagonal.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('d648ef04-a61a-4787-bcac-ef49ef7ac525', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — MLar Cambeba e Lago', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1139, '2026-05-08', 'paid', '2026-05-08', 1139, 'Pago - Saldo Meta — MLar Cambeba e Lago');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('e9f2739f-a27c-40da-9e62-7a42a200b379', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'd648ef04-a61a-4787-bcac-ef49ef7ac525', 1139, '2026-05-08', 'Pago - Saldo Meta — MLar Cambeba e Lago');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('b950ee01-9a3e-431a-956f-060e0ffc2251', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-08', 'Saldo Meta — MLar Cambeba e Lago', 'd648ef04-a61a-4787-bcac-ef49ef7ac525', 'e9f2739f-a27c-40da-9e62-7a42a200b379', 'Pix', 'Pago - Saldo Meta — MLar Cambeba e Lago');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('1336a9da-b42d-4e55-b74a-6a5189578c1e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — BSWave e Maré', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1139, '2026-05-08', 'paid', '2026-05-08', 1139, 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d4277e1c-c223-41b7-bbfc-8abaf960bda1', 'e11042be-3d22-4048-9380-ac71e8dc9252', '1336a9da-b42d-4e55-b74a-6a5189578c1e', 1139, '2026-05-08', 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('7759a098-9a0a-4e06-8346-5b791e04166d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-08', 'Saldo Meta — BSWave e Maré', '1336a9da-b42d-4e55-b74a-6a5189578c1e', 'd4277e1c-c223-41b7-bbfc-8abaf960bda1', 'Pix', 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('cd2c95dc-5a4d-469d-b7cc-4ecff4f2a523', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Compra de 03 celulares', 'afdfc56a-6c1d-4e88-aa3e-f3b5f41c70dc', 750, '2026-05-14', 'paid', '2026-05-14', 750, 'Pago - Celulares');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2e5806a9-6ea2-4122-a6d9-a8d12b6df578', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'cd2c95dc-5a4d-469d-b7cc-4ecff4f2a523', 750, '2026-05-14', 'Pago - Celulares');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('f5834683-93e7-4b75-93ca-b23e769aea86', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 750, '2026-05-14', 'Compra de 03 celulares', 'cd2c95dc-5a4d-469d-b7cc-4ecff4f2a523', '2e5806a9-6ea2-4122-a6d9-a8d12b6df578', 'Pix', 'Pago - Celulares');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('69262176-408d-48ac-b977-29c352c08840', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — MLar Cambeba e Lago', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1139, '2026-05-14', 'paid', '2026-05-14', 1139, 'Pago - Saldo Meta - Mlar Lago e Cambeba.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('429825a9-ead0-47b6-b77c-4e87fb2a46b3', 'e11042be-3d22-4048-9380-ac71e8dc9252', '69262176-408d-48ac-b977-29c352c08840', 1139, '2026-05-14', 'Pago - Saldo Meta - Mlar Lago e Cambeba.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('9ec19a92-07a7-4286-8cda-6bbd08df2a36', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-14', 'Saldo Meta — MLar Cambeba e Lago', '69262176-408d-48ac-b977-29c352c08840', '429825a9-ead0-47b6-b77c-4e87fb2a46b3', 'Pix', 'Pago - Saldo Meta - Mlar Lago e Cambeba.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('44602e0d-d74a-44df-b6f8-865ab23040b6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google — Fortaleza', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 1000, '2026-05-15', 'paid', '2026-05-15', 1000, 'Pago - Saldo Google — Fortaleza.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('7a4bac01-9db7-4317-944b-0a0ea8464870', 'e11042be-3d22-4048-9380-ac71e8dc9252', '44602e0d-d74a-44df-b6f8-865ab23040b6', 1000, '2026-05-15', 'Pago - Saldo Google — Fortaleza.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('06cfae8c-1d8a-495f-a801-22b049d741be', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-15', 'Saldo Google — Fortaleza', '44602e0d-d74a-44df-b6f8-865ab23040b6', '7a4bac01-9db7-4317-944b-0a0ea8464870', 'Pix', 'Pago - Saldo Google — Fortaleza.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('3f82ac06-2364-4529-bee6-38c06c178a04', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google — Imoveis Praia', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 600, '2026-05-15', 'paid', '2026-05-15', 600, 'Pago - Saldo Google — Imoveis Praia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('3eec6b85-8297-4566-9a2c-42bb9a537e7a', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3f82ac06-2364-4529-bee6-38c06c178a04', 600, '2026-05-15', 'Pago - Saldo Google — Imoveis Praia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('ebc1b6b5-f07d-4ef3-afe2-0e61038db2e0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 600, '2026-05-15', 'Saldo Google — Imoveis Praia', '3f82ac06-2364-4529-bee6-38c06c178a04', '3eec6b85-8297-4566-9a2c-42bb9a537e7a', 'Pix', 'Pago - Saldo Google — Imoveis Praia.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('aed0b834-ba27-4303-961d-7a1932a44003', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Placas do escritório', 'f8d56c53-a2a4-41c2-9372-7c9560332cf4', 375, '2026-05-15', 'paid', '2026-05-15', 375, 'Pago - Placas Escritório');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('643f7485-e605-4e4b-8a8b-edd46e3647e2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'aed0b834-ba27-4303-961d-7a1932a44003', 375, '2026-05-15', 'Pago - Placas Escritório');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('0b6d1538-1dbc-4043-a929-e6fdddad445d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 375, '2026-05-15', 'Placas do escritório', 'aed0b834-ba27-4303-961d-7a1932a44003', '643f7485-e605-4e4b-8a8b-edd46e3647e2', 'Pix', 'Pago - Placas Escritório');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('85112875-227d-4378-94d1-05ad1f7717b7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google — Outros Estados', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 500, '2026-05-15', 'paid', '2026-05-15', 500, 'Pago - Saldo Google — Outro Estados.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('c8837790-b3f7-40ac-8719-8bb40b3dfc09', 'e11042be-3d22-4048-9380-ac71e8dc9252', '85112875-227d-4378-94d1-05ad1f7717b7', 500, '2026-05-15', 'Pago - Saldo Google — Outro Estados.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('1fd95c79-d9c8-45fd-8d9e-6ae2d84791bf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-15', 'Saldo Google — Outros Estados', '85112875-227d-4378-94d1-05ad1f7717b7', 'c8837790-b3f7-40ac-8719-8bb40b3dfc09', 'Pix', 'Pago - Saldo Google — Outro Estados.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('f5525ca2-7211-40c8-bb61-5f387e1fdaac', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno - Bella Aldeota (Mateus)', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 5400.47, '2026-05-18', 'paid', '2026-05-18', 5400.47, 'Pago - Comissão Reno - Bella Aldeota');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('53cf08a9-2f2f-461e-a930-9c76abc204b2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'f5525ca2-7211-40c8-bb61-5f387e1fdaac', 5400.47, '2026-05-18', 'Pago - Comissão Reno - Bella Aldeota');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('cadc0334-8683-4b6a-9941-9e9142ae0a0c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 5400.47, '2026-05-18', 'Comissão Reno - Bella Aldeota (Mateus)', 'f5525ca2-7211-40c8-bb61-5f387e1fdaac', '53cf08a9-2f2f-461e-a930-9c76abc204b2', 'Pix', 'Pago - Comissão Reno - Bella Aldeota');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ad353805-5558-4eac-91ba-11921014676a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — BSWave e Maré', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1139, '2026-05-18', 'paid', '2026-05-18', 1139, 'Pago - Nota Fiscal - Saldo Meta — BSWave e Maré - 18052026.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('f9aa9d85-7dee-4550-bfd5-7f3d635aedcb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ad353805-5558-4eac-91ba-11921014676a', 1139, '2026-05-18', 'Pago - Nota Fiscal - Saldo Meta — BSWave e Maré - 18052026.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('b478f940-3181-4a10-8399-8ee2c0b794bf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-18', 'Saldo Meta — BSWave e Maré', 'ad353805-5558-4eac-91ba-11921014676a', 'f9aa9d85-7dee-4550-bfd5-7f3d635aedcb', 'Pix', 'Pago - Nota Fiscal - Saldo Meta — BSWave e Maré - 18052026.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('384fe879-db6f-47bd-871b-a55a6919c254', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angelica - Bella Aldeota (Mateus)', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 500, '2026-05-18', 'paid', '2026-05-18', 500, 'Pago - Nota Fiscal - Comissão Bella Aldeota - Mateus.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('59de6a3e-6e69-4559-acbd-0eefa5c9e676', 'e11042be-3d22-4048-9380-ac71e8dc9252', '384fe879-db6f-47bd-871b-a55a6919c254', 500, '2026-05-18', 'Pago - Nota Fiscal - Comissão Bella Aldeota - Mateus.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('38974cbe-c5c9-4786-a35a-51e3c763776f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-18', 'Comissão Angelica - Bella Aldeota (Mateus)', '384fe879-db6f-47bd-871b-a55a6919c254', '59de6a3e-6e69-4559-acbd-0eefa5c9e676', 'Pix', 'Pago - Nota Fiscal - Comissão Bella Aldeota - Mateus.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('9fc0ded1-c079-4d61-a597-37cd7d358abe', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bônus Reno - Bella Aldeota (Mateus)', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 1495.28, '2026-05-18', 'paid', '2026-05-18', 1495.28, 'Pago - Bônus  Bella Aldeota -  Reno');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('18556abc-224a-4b3b-99c2-a2dd1c44bfac', 'e11042be-3d22-4048-9380-ac71e8dc9252', '9fc0ded1-c079-4d61-a597-37cd7d358abe', 1495.28, '2026-05-18', 'Pago - Bônus  Bella Aldeota -  Reno');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('941c33f8-e266-4e54-869b-9f8a4401b62b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1495.28, '2026-05-18', 'Bônus Reno - Bella Aldeota (Mateus)', '9fc0ded1-c079-4d61-a597-37cd7d358abe', '18556abc-224a-4b3b-99c2-a2dd1c44bfac', 'Pix', 'Pago - Bônus  Bella Aldeota -  Reno');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('b4ad5ff7-a12b-4ed9-8d4a-de84ed7f2651', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - MLar Cambeba e Lago', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1139, '2026-05-20', 'paid', '2026-05-20', 1139, 'Pago - Nota Fiscal - Mlar Lago e Cambeba.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('0b4bb8ce-be17-432f-acbe-6b7ad86b9a58', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'b4ad5ff7-a12b-4ed9-8d4a-de84ed7f2651', 1139, '2026-05-20', 'Pago - Nota Fiscal - Mlar Lago e Cambeba.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('8324815b-0cd0-49ca-8b04-ad41438ffbe9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-20', 'Saldo Meta - MLar Cambeba e Lago', 'b4ad5ff7-a12b-4ed9-8d4a-de84ed7f2651', '0b4bb8ce-be17-432f-acbe-6b7ad86b9a58', 'Pix', 'Pago - Nota Fiscal - Mlar Lago e Cambeba.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('3a0469ae-4507-4f92-a981-0a7863a2c5b7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - La Vie e Inc Parquelandia', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 800, '2026-05-22', 'paid', '2026-05-22', 800, 'Pago - Saldo Meta - La Vie e Inc Parquelandia');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('4ce54214-f4d8-41e5-ad71-33cd75ffd41e', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3a0469ae-4507-4f92-a981-0a7863a2c5b7', 800, '2026-05-22', 'Pago - Saldo Meta - La Vie e Inc Parquelandia');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('6f0f8db0-2952-447f-ae3f-95ade409c27a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 800, '2026-05-22', 'Saldo Meta - La Vie e Inc Parquelandia', '3a0469ae-4507-4f92-a981-0a7863a2c5b7', '4ce54214-f4d8-41e5-ad71-33cd75ffd41e', 'Pix', 'Pago - Saldo Meta - La Vie e Inc Parquelandia');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('e4064f8f-cfa3-4590-bc46-750b45220586', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angelica - Maré - Beatriz', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 500, '2026-05-22', 'paid', '2026-05-22', 500, 'Pago - Nota Fiscal - Comissão Angélica.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('130f61d6-40cb-4041-ade6-3d2dbc7b300c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'e4064f8f-cfa3-4590-bc46-750b45220586', 500, '2026-05-22', 'Pago - Nota Fiscal - Comissão Angélica.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('44a21e60-a8af-4b04-9d12-d24fa565ee50', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-22', 'Comissão Angelica - Maré - Beatriz', 'e4064f8f-cfa3-4590-bc46-750b45220586', '130f61d6-40cb-4041-ade6-3d2dbc7b300c', 'Pix', 'Pago - Nota Fiscal - Comissão Angélica.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('d715f6d6-e858-488e-801e-720058be20ba', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Felipe- Maré - Beatriz', '9a1ef9d8-82c0-407c-b586-b9e0cfb3cb1a', 250, '2026-05-24', 'paid', '2026-05-24', 250, 'Pago- Nota Fiscal - Comissão Felipe.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('62a8085b-2737-4fad-8da8-9ea1e05a040e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'd715f6d6-e858-488e-801e-720058be20ba', 250, '2026-05-24', 'Pago- Nota Fiscal - Comissão Felipe.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('3e5132e3-31a8-494c-a11a-7749b3198a91', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 250, '2026-05-24', 'Comissão Felipe- Maré - Beatriz', 'd715f6d6-e858-488e-801e-720058be20ba', '62a8085b-2737-4fad-8da8-9ea1e05a040e', 'Pix', 'Pago- Nota Fiscal - Comissão Felipe.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('04dfc188-967d-4568-a2da-92c98adc3842', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Pedro- Maré - Beatriz', '8b26015a-c9f3-446a-9530-f47757f532da', 250, '2026-05-24', 'paid', '2026-05-24', 250, 'Nota Fiscal - Comissão Pedro.PDF');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('29085217-34cf-4be2-8101-8c84c2086008', 'e11042be-3d22-4048-9380-ac71e8dc9252', '04dfc188-967d-4568-a2da-92c98adc3842', 250, '2026-05-24', 'Nota Fiscal - Comissão Pedro.PDF');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('af77db0f-d11c-477c-9138-276e95d826c1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 250, '2026-05-24', 'Comissão Pedro- Maré - Beatriz', '04dfc188-967d-4568-a2da-92c98adc3842', '29085217-34cf-4be2-8101-8c84c2086008', 'Pix', 'Nota Fiscal - Comissão Pedro.PDF');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('fd25c14d-e96e-4cd0-be13-9d4483016629', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico/Orizon/Seano', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-05-27', 'paid', '2026-05-27', 1000, 'Pago - Saldo Meta - Atlântico/Orizon/Seano - 27/05');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('4a9d8ede-e116-4c16-9bf5-b30354728b5a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'fd25c14d-e96e-4cd0-be13-9d4483016629', 1000, '2026-05-27', 'Pago - Saldo Meta - Atlântico/Orizon/Seano - 27/05');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('a639f91c-9be1-48a8-a87a-011fb7fe6c92', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-27', 'Saldo Meta - Atlântico/Orizon/Seano', 'fd25c14d-e96e-4cd0-be13-9d4483016629', '4a9d8ede-e116-4c16-9bf5-b30354728b5a', 'Pix', 'Pago - Saldo Meta - Atlântico/Orizon/Seano - 27/05');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('faf20ee0-d82f-4dd5-ae89-3d06e85738e2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Mlar Cambeba / Lago', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-05-27', 'paid', '2026-05-27', 1000, 'Pago - Saldo Meta - Mlar lago/cambeba - 27/05');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('3e7e25b3-ede4-4d96-9146-6abfb2f30bbc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'faf20ee0-d82f-4dd5-ae89-3d06e85738e2', 1000, '2026-05-27', 'Pago - Saldo Meta - Mlar lago/cambeba - 27/05');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('aa28956c-ff3d-4cfd-b922-1b0fc934bd2e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-27', 'Saldo Meta - Mlar Cambeba / Lago', 'faf20ee0-d82f-4dd5-ae89-3d06e85738e2', '3e7e25b3-ede4-4d96-9146-6abfb2f30bbc', 'Pix', 'Pago - Saldo Meta - Mlar lago/cambeba - 27/05');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('b4970b0b-2601-4d7f-a64b-1ea5231322c3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob Fortaleza', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 1000, '2026-05-27', 'paid', '2026-05-27', 1000, 'Pago - Saldo Googld - Re9 Imob Fortaleza - 27/05');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('e3137600-7b68-4aa6-a757-67b6463320a7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'b4970b0b-2601-4d7f-a64b-1ea5231322c3', 1000, '2026-05-27', 'Pago - Saldo Googld - Re9 Imob Fortaleza - 27/05');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('9cbbeb0a-65a3-4c5a-812f-a3902dfec888', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-27', 'Saldo Google - Re9 Imob Fortaleza', 'b4970b0b-2601-4d7f-a64b-1ea5231322c3', 'e3137600-7b68-4aa6-a757-67b6463320a7', 'Pix', 'Pago - Saldo Googld - Re9 Imob Fortaleza - 27/05');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('b8b0567c-353d-4e8e-ba54-9e0853bef513', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Salário Angélica', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 2500, '2026-05-27', 'paid', '2026-05-27', 2500, 'Pago - Nota Fiscal - Salário - Angélica.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('a40f9d0f-d9fe-4fe1-81c5-79b2ee2f2e1d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'b8b0567c-353d-4e8e-ba54-9e0853bef513', 2500, '2026-05-27', 'Pago - Nota Fiscal - Salário - Angélica.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('7232b7ea-cd80-4b06-9b6a-98b68cd7937f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2500, '2026-05-27', 'Salário Angélica', 'b8b0567c-353d-4e8e-ba54-9e0853bef513', 'a40f9d0f-d9fe-4fe1-81c5-79b2ee2f2e1d', 'Pix', 'Pago - Nota Fiscal - Salário - Angélica.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('7153ddfc-2bb7-4b34-9525-be7a5c223997', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico/Orizon/Seano', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-05-29', 'paid', '2026-05-29', 1000, 'Pago - Saldo Meta - AtlanticoSeanoOrizon 3 - Maio26.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('35d3341b-a034-4975-b964-1cafe3d64fb5', 'e11042be-3d22-4048-9380-ac71e8dc9252', '7153ddfc-2bb7-4b34-9525-be7a5c223997', 1000, '2026-05-29', 'Pago - Saldo Meta - AtlanticoSeanoOrizon 3 - Maio26.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('d23d0828-6971-4acf-9fe9-8ddf55f6826b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-29', 'Saldo Meta - Atlântico/Orizon/Seano', '7153ddfc-2bb7-4b34-9525-be7a5c223997', '35d3341b-a034-4975-b964-1cafe3d64fb5', 'Pix', 'Pago - Saldo Meta - AtlanticoSeanoOrizon 3 - Maio26.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('21874764-14f1-43bc-a6be-d8e2f1ba210a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - BSWave e Maré', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 500, '2026-05-29', 'paid', '2026-05-29', 500, 'Pago - Saldo Meta - BSWave e Mare - Maio26 2.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('61e34584-f23a-47e9-94c2-1b6aa3f690d4', 'e11042be-3d22-4048-9380-ac71e8dc9252', '21874764-14f1-43bc-a6be-d8e2f1ba210a', 500, '2026-05-29', 'Pago - Saldo Meta - BSWave e Mare - Maio26 2.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('354b1575-a004-4c22-8ef4-1f9bdde6373a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-29', 'Saldo Meta - BSWave e Maré', '21874764-14f1-43bc-a6be-d8e2f1ba210a', '61e34584-f23a-47e9-94c2-1b6aa3f690d4', 'Pix', 'Pago - Saldo Meta - BSWave e Mare - Maio26 2.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('1cac2916-2197-4bc5-b5e5-45c57f387ccf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno - Bella Aldeota (Mateus)', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 13623.4, '2026-06-01', 'paid', '2026-06-01', 13623.4, 'Pago - Comissão Reno.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('ab023d2a-0e6c-45aa-af04-921b6437de69', 'e11042be-3d22-4048-9380-ac71e8dc9252', '1cac2916-2197-4bc5-b5e5-45c57f387ccf', 13623.4, '2026-06-01', 'Pago - Comissão Reno.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('4ee84813-5edd-4e1c-8d40-0b7e36696c38', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 13623.4, '2026-06-01', 'Comissão Reno - Bella Aldeota (Mateus)', '1cac2916-2197-4bc5-b5e5-45c57f387ccf', 'ab023d2a-0e6c-45aa-af04-921b6437de69', 'Pix', 'Pago - Comissão Reno.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('e153b270-516d-43d5-ada6-db2fbdbbd953', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico/Orizon/Seano', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1139, '2026-06-02', 'paid', '2026-06-02', 1139, 'Pago - Atlântico  Orizon  Seano  Inc Cambeba.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('276245f5-9148-4c88-b7c3-37c92a270ac8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'e153b270-516d-43d5-ada6-db2fbdbbd953', 1139, '2026-06-02', 'Pago - Atlântico  Orizon  Seano  Inc Cambeba.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('9660a1db-c26e-401f-bd59-4cab37b84e5a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-06-02', 'Saldo Meta - Atlântico/Orizon/Seano', 'e153b270-516d-43d5-ada6-db2fbdbbd953', '276245f5-9148-4c88-b7c3-37c92a270ac8', 'Pix', 'Pago - Atlântico  Orizon  Seano  Inc Cambeba.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('b04eca69-e96f-45ad-ae32-d1791eb29d38', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — BSWave e Maré', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 570, '2026-06-02', 'paid', '2026-06-02', 570, 'Pago - BS Wave  Maré.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5830c28b-e908-452f-b968-b170a7e9d234', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'b04eca69-e96f-45ad-ae32-d1791eb29d38', 570, '2026-06-02', 'Pago - BS Wave  Maré.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('41e89ae9-d0c1-4ca0-945f-b9229a71ad77', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 570, '2026-06-02', 'Saldo Meta — BSWave e Maré', 'b04eca69-e96f-45ad-ae32-d1791eb29d38', '5830c28b-e908-452f-b968-b170a7e9d234', 'Pix', 'Pago - BS Wave  Maré.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('f6fe5522-2806-4556-ad18-ebd34d1841f6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Mlar Cambeba / Lago', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 570, '2026-06-02', 'paid', '2026-06-02', 570, 'Pago - MLar Cambeba  MLar Lago.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d98f3fca-dcfa-4763-ad49-94bb0d20c632', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'f6fe5522-2806-4556-ad18-ebd34d1841f6', 570, '2026-06-02', 'Pago - MLar Cambeba  MLar Lago.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('d75c6bba-d5cc-4606-9515-fc3be9e295dd', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 570, '2026-06-02', 'Saldo Meta - Mlar Cambeba / Lago', 'f6fe5522-2806-4556-ad18-ebd34d1841f6', 'd98f3fca-dcfa-4763-ad49-94bb0d20c632', 'Pix', 'Pago - MLar Cambeba  MLar Lago.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('759e90cb-3ae4-4083-86eb-8083c02db15b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Imóveis Praia', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 500, '2026-06-04', 'paid', '2026-06-04', 500, 'Pgto Google - RE9Imob Imoveis Praia - Jun26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('c7595dd3-3654-4a40-b725-336c6892cc3a', 'e11042be-3d22-4048-9380-ac71e8dc9252', '759e90cb-3ae4-4083-86eb-8083c02db15b', 500, '2026-06-04', 'Pgto Google - RE9Imob Imoveis Praia - Jun26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('46c8165d-0a9d-418a-9cf2-e6876262296b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-04', 'Saldo Google - RE9 Imob - Imóveis Praia', '759e90cb-3ae4-4083-86eb-8083c02db15b', 'c7595dd3-3654-4a40-b725-336c6892cc3a', 'Pix', 'Pgto Google - RE9Imob Imoveis Praia - Jun26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('a210828a-cdb8-4863-9b6d-89b580f6c584', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Internacional', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 500, '2026-06-04', 'paid', '2026-06-04', 500, 'Pgto Google - RE9Imob Internacional - Jun26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('ea78dd51-45e6-4b1c-a923-212a213da6d4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'a210828a-cdb8-4863-9b6d-89b580f6c584', 500, '2026-06-04', 'Pgto Google - RE9Imob Internacional - Jun26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('7599c30c-6d9a-4113-96d1-72fc5cc8f106', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-04', 'Saldo Google - RE9 Imob - Internacional', 'a210828a-cdb8-4863-9b6d-89b580f6c584', 'ea78dd51-45e6-4b1c-a923-212a213da6d4', 'Pix', 'Pgto Google - RE9Imob Internacional - Jun26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ddf6d091-71dd-4b85-8d58-1802de134bbf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico / Orizon / Seano / IncCambeba', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 500, '2026-06-04', 'paid', '2026-06-04', 500, 'Pgto Meta - Atlantico, Orizon, Seano, Inc Cambeba.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('c4d89807-9c6d-452e-8c72-20ab89922980', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ddf6d091-71dd-4b85-8d58-1802de134bbf', 500, '2026-06-04', 'Pgto Meta - Atlantico, Orizon, Seano, Inc Cambeba.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('bad53ea2-784a-43f1-ba74-4148a7575178', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-04', 'Saldo Meta - Atlântico / Orizon / Seano / IncCambeba', 'ddf6d091-71dd-4b85-8d58-1802de134bbf', 'c4d89807-9c6d-452e-8c72-20ab89922980', 'Pix', 'Pgto Meta - Atlantico, Orizon, Seano, Inc Cambeba.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('43381083-aa9e-438c-ac45-fd956ead6756', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Bella Aldeota / Bella Rio / BS Rubi', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-06-04', 'paid', '2026-06-04', 1000, 'Pgto Meta - Bella Aldeota, Bella Rio, BS Rubi.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2a8a79f4-b4ea-468f-8ecb-6c84b5bc8f00', 'e11042be-3d22-4048-9380-ac71e8dc9252', '43381083-aa9e-438c-ac45-fd956ead6756', 1000, '2026-06-04', 'Pgto Meta - Bella Aldeota, Bella Rio, BS Rubi.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('635e26d0-1a14-43ca-9945-c96e63c130a6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-04', 'Saldo Meta - Bella Aldeota / Bella Rio / BS Rubi', '43381083-aa9e-438c-ac45-fd956ead6756', '2a8a79f4-b4ea-468f-8ecb-6c84b5bc8f00', 'Pix', 'Pgto Meta - Bella Aldeota, Bella Rio, BS Rubi.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('03138114-d824-4caa-8d6d-d7cfe475554a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - BSWave / Maré / BC Cumbuco / VistaCoqueiral', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 500, '2026-06-04', 'paid', '2026-06-04', 500, 'Pgto Meta - BS Wave, Maré, BC Cumbuco, Vista Coqueiral.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('bba726f0-cc6a-4e7d-a805-bc37c76a51c8', 'e11042be-3d22-4048-9380-ac71e8dc9252', '03138114-d824-4caa-8d6d-d7cfe475554a', 500, '2026-06-04', 'Pgto Meta - BS Wave, Maré, BC Cumbuco, Vista Coqueiral.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('c2e8b460-6775-44bc-bf75-d28a11785a78', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-04', 'Saldo Meta - BSWave / Maré / BC Cumbuco / VistaCoqueiral', '03138114-d824-4caa-8d6d-d7cfe475554a', 'bba726f0-cc6a-4e7d-a805-bc37c76a51c8', 'Pix', 'Pgto Meta - BS Wave, Maré, BC Cumbuco, Vista Coqueiral.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('09729aa7-17c8-4820-bc5d-f3ebdfc2fe1f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Mlar Cambeba / Lago', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 500, '2026-06-04', 'paid', '2026-06-04', 500, 'Pgto Meta - MLar Cameba, MLar Lago.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('a6e185b5-e963-40c9-bff8-00f1b11179c4', 'e11042be-3d22-4048-9380-ac71e8dc9252', '09729aa7-17c8-4820-bc5d-f3ebdfc2fe1f', 500, '2026-06-04', 'Pgto Meta - MLar Cameba, MLar Lago.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('d2a2ad89-759c-4e0b-872b-76832a9e9655', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-04', 'Saldo Meta - Mlar Cambeba / Lago', '09729aa7-17c8-4820-bc5d-f3ebdfc2fe1f', 'a6e185b5-e963-40c9-bff8-00f1b11179c4', 'Pix', 'Pgto Meta - MLar Cameba, MLar Lago.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('4784c230-1d87-409c-827a-d23378882b90', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - La Vie / Inc Parquelandia', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 300, '2026-06-04', 'paid', '2026-06-04', 300, 'Pgto Meta - La Vie, Inc Parquelandia.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('97dbc908-16ed-45a6-add4-83cc811d9781', 'e11042be-3d22-4048-9380-ac71e8dc9252', '4784c230-1d87-409c-827a-d23378882b90', 300, '2026-06-04', 'Pgto Meta - La Vie, Inc Parquelandia.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('327fbdd7-b893-430c-ab90-0c7d1aa4e523', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-06-04', 'Saldo Meta - La Vie / Inc Parquelandia', '4784c230-1d87-409c-827a-d23378882b90', '97dbc908-16ed-45a6-add4-83cc811d9781', 'Pix', 'Pgto Meta - La Vie, Inc Parquelandia.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('cef18df6-9996-4135-b8a6-aaee84a0cdbb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Fortaleza', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 1000, '2026-06-04', 'paid', '2026-06-04', 1000, 'Pgto Google - RE9Imob Fortaleza - Jun26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('0c24c7de-7136-4769-9c08-441f37fe0f89', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'cef18df6-9996-4135-b8a6-aaee84a0cdbb', 1000, '2026-06-04', 'Pgto Google - RE9Imob Fortaleza - Jun26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('b83812ea-d576-47e9-b10b-10a16e1fb9a6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-04', 'Saldo Google - RE9 Imob - Fortaleza', 'cef18df6-9996-4135-b8a6-aaee84a0cdbb', '0c24c7de-7136-4769-9c08-441f37fe0f89', 'Pix', 'Pgto Google - RE9Imob Fortaleza - Jun26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('dd46e594-3ef5-4748-86c9-211835ac2f67', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Contabilidade', '6d5fa8f9-a5c5-41bd-9544-a64d7ad7dd82', 300, '2026-06-10', 'paid', '2026-06-10', 300, 'Pago - Contabilidade.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('ec646a82-bf84-4fa1-a49b-12b29b6888cd', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'dd46e594-3ef5-4748-86c9-211835ac2f67', 300, '2026-06-10', 'Pago - Contabilidade.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('2f467936-21ee-4508-9684-afd6dfa310de', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-06-10', 'Comissão Contabilidade', 'dd46e594-3ef5-4748-86c9-211835ac2f67', 'ec646a82-bf84-4fa1-a49b-12b29b6888cd', 'Pix', 'Pago - Contabilidade.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('6a2bf687-1706-4832-b907-af9e25f011f3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Imposto Maio/26', '341f3191-5254-4400-b763-2e3071276044', 4700.39, '2026-06-11', 'paid', '2026-06-11', 4700.39, 'Pago - Impostos.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5b24af6c-e749-49d4-8f62-431a2e6e7611', 'e11042be-3d22-4048-9380-ac71e8dc9252', '6a2bf687-1706-4832-b907-af9e25f011f3', 4700.39, '2026-06-11', 'Pago - Impostos.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('ff280767-7d47-41f9-9594-5f43e7f309e0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 4700.39, '2026-06-11', 'Imposto Maio/26', '6a2bf687-1706-4832-b907-af9e25f011f3', '5b24af6c-e749-49d4-8f62-431a2e6e7611', 'Pix', 'Pago - Impostos.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('c0022e3a-0a28-4c59-99b8-18c0f4b680ae', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Salário Angélica', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 2500, '2026-06-18', 'paid', '2026-06-18', 2500, 'Pago - Salário Angélica.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d97bd157-aa0c-4dd4-ac2f-d2ecb729febe', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c0022e3a-0a28-4c59-99b8-18c0f4b680ae', 2500, '2026-06-18', 'Pago - Salário Angélica.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('7c73a67d-e796-47c3-9dd6-509c0e70d788', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2500, '2026-06-18', 'Salário Angélica', 'c0022e3a-0a28-4c59-99b8-18c0f4b680ae', 'd97bd157-aa0c-4dd4-ac2f-d2ecb729febe', 'Pix', 'Pago - Salário Angélica.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('d75cf4e9-d96e-4627-b74c-73e2e644d8ae', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pgto Google RE9 Imob - Fortaleza', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 1000, '2026-06-18', 'paid', '2026-06-18', 1000, 'Pago - Salário Angélica.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('f64a1fe3-dbba-4381-95f3-01472afa7761', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'd75cf4e9-d96e-4627-b74c-73e2e644d8ae', 1000, '2026-06-18', 'Pago - Salário Angélica.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('fcb17e44-cde2-4be0-93cb-73ee1049b2ba', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-18', 'Pgto Google RE9 Imob - Fortaleza', 'd75cf4e9-d96e-4627-b74c-73e2e644d8ae', 'f64a1fe3-dbba-4381-95f3-01472afa7761', 'Pix', 'Pago - Salário Angélica.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('28e7e92c-a69d-46d7-8e92-e4298bfe47c2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pgto Google RE9 Imob - Imóveis Praia', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 400, '2026-06-18', 'paid', '2026-06-18', 400, 'Pago - Google RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('66c17d0c-57fd-4445-a29c-2a36408638e4', 'e11042be-3d22-4048-9380-ac71e8dc9252', '28e7e92c-a69d-46d7-8e92-e4298bfe47c2', 400, '2026-06-18', 'Pago - Google RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('09016563-1afe-4bc4-8076-2b864012cfce', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-06-18', 'Pgto Google RE9 Imob - Imóveis Praia', '28e7e92c-a69d-46d7-8e92-e4298bfe47c2', '66c17d0c-57fd-4445-a29c-2a36408638e4', 'Pix', 'Pago - Google RE9 Imob - Imóveis Praia.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('a00b23e8-aa17-4fa5-b27a-667e1ff8d1e2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pgto Google RE9 Imob - Outros Estados', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 500, '2026-06-18', 'paid', '2026-06-18', 500, 'Pago - Google RE9 Imob - Outros Estados.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('8d9ae7a3-d57c-4307-acac-b4d403d278bf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'a00b23e8-aa17-4fa5-b27a-667e1ff8d1e2', 500, '2026-06-18', 'Pago - Google RE9 Imob - Outros Estados.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('67d79e89-497b-4b62-8ad9-d60e2fa9bded', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-18', 'Pgto Google RE9 Imob - Outros Estados', 'a00b23e8-aa17-4fa5-b27a-667e1ff8d1e2', '8d9ae7a3-d57c-4307-acac-b4d403d278bf', 'Pix', 'Pago - Google RE9 Imob - Outros Estados.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('20af3957-730e-423e-a84b-395c9bf6c906', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pgto Google RE9 Imob - Internacional', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 300, '2026-06-18', 'paid', '2026-06-18', 300, 'Pago - Google RE9 Imob - Internacional.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2f40bbf7-0ee4-4d71-9e25-47fa673fcc6c', 'e11042be-3d22-4048-9380-ac71e8dc9252', '20af3957-730e-423e-a84b-395c9bf6c906', 300, '2026-06-18', 'Pago - Google RE9 Imob - Internacional.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('a22a5211-a081-4c8a-8532-bd5c68c84b1e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-06-18', 'Pgto Google RE9 Imob - Internacional', '20af3957-730e-423e-a84b-395c9bf6c906', '2f40bbf7-0ee4-4d71-9e25-47fa673fcc6c', 'Pix', 'Pago - Google RE9 Imob - Internacional.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('da7eb424-b109-4973-bd8a-476201523777', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno - MLar Kennedy (Lia e Jonathan)', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 7466.78, '2026-06-18', 'paid', '2026-06-18', 7466.78, 'Pago - Comissao Reno MLar Kennedy Lia e Jonathan.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('a68c95c4-b630-430f-9c3c-fe53366d47a4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'da7eb424-b109-4973-bd8a-476201523777', 7466.78, '2026-06-18', 'Pago - Comissao Reno MLar Kennedy Lia e Jonathan.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('e3a70331-6b14-4277-bdf2-30f3af11a2bc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 7466.78, '2026-06-18', 'Comissão Reno - MLar Kennedy (Lia e Jonathan)', 'da7eb424-b109-4973-bd8a-476201523777', 'a68c95c4-b630-430f-9c3c-fe53366d47a4', 'Pix', 'Pago - Comissao Reno MLar Kennedy Lia e Jonathan.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('27b9c93e-1c5c-418f-a67d-efc5f2f48166', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico  Orizon  Seano  Inc Cambeba', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-06-19', 'paid', '2026-06-19', 1000, 'Pago -Saldo Meta - Atlântico  Orizon  Seano  Inc Cambeba.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('70ed0937-92b7-4b3c-bcc9-7d5b3ae4d899', 'e11042be-3d22-4048-9380-ac71e8dc9252', '27b9c93e-1c5c-418f-a67d-efc5f2f48166', 1000, '2026-06-19', 'Pago -Saldo Meta - Atlântico  Orizon  Seano  Inc Cambeba.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('68c6d5c2-aeb3-47f8-9480-8a499012bacc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-19', 'Saldo Meta - Atlântico  Orizon  Seano  Inc Cambeba', '27b9c93e-1c5c-418f-a67d-efc5f2f48166', '70ed0937-92b7-4b3c-bcc9-7d5b3ae4d899', 'Pix', 'Pago -Saldo Meta - Atlântico  Orizon  Seano  Inc Cambeba.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('dc9f2c05-800c-4148-a6e5-fe8b28fd275b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angélica', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 500, '2026-06-19', 'paid', '2026-06-19', 500, 'Comissão Angélica.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('519ae347-c671-4493-b9d7-a84b74d5e524', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'dc9f2c05-800c-4148-a6e5-fe8b28fd275b', 500, '2026-06-19', 'Comissão Angélica.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('6f5bde1c-25b4-4fa7-9071-afd06246f988', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-19', 'Comissão Angélica', 'dc9f2c05-800c-4148-a6e5-fe8b28fd275b', '519ae347-c671-4493-b9d7-a84b74d5e524', 'Pix', 'Comissão Angélica.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('9a4f7a89-59f7-4beb-b7dd-f73829624c05', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Felipe', '9a1ef9d8-82c0-407c-b586-b9e0cfb3cb1a', 250, '2026-06-19', 'paid', '2026-06-19', 250, 'Comissão Felipe.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('c0ae4ef0-3021-4788-83ec-238c1fcd7374', 'e11042be-3d22-4048-9380-ac71e8dc9252', '9a4f7a89-59f7-4beb-b7dd-f73829624c05', 250, '2026-06-19', 'Comissão Felipe.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('6b0e5f47-e171-42cf-b895-2a221f03e055', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 250, '2026-06-19', 'Comissão Felipe', '9a4f7a89-59f7-4beb-b7dd-f73829624c05', 'c0ae4ef0-3021-4788-83ec-238c1fcd7374', 'Pix', 'Comissão Felipe.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('6c0d0381-29f4-4beb-b93a-3869e98bcb88', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Bella Aldeota Bella Rio  BS Rubi', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-06-19', 'paid', '2026-06-19', 1000, 'Pago - Saldo Meta - Bella Aldeota Bella Rio  BS Rubi.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('0056a8b9-670e-4903-9221-1e9b09b3bdee', 'e11042be-3d22-4048-9380-ac71e8dc9252', '6c0d0381-29f4-4beb-b93a-3869e98bcb88', 1000, '2026-06-19', 'Pago - Saldo Meta - Bella Aldeota Bella Rio  BS Rubi.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('0c75463d-1367-4046-834b-0801ab344ed7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-19', 'Saldo Meta - Bella Aldeota Bella Rio  BS Rubi', '6c0d0381-29f4-4beb-b93a-3869e98bcb88', '0056a8b9-670e-4903-9221-1e9b09b3bdee', 'Pix', 'Pago - Saldo Meta - Bella Aldeota Bella Rio  BS Rubi.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('353e5a99-9085-4402-9029-e55f5d33c810', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - BSWave  Maré  BC Cumbuco  Vista Coqueiral', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-06-19', 'paid', '2026-06-19', 1000, 'Saldo Meta - BSWave  Maré  BC Cumbuco  Vista Coqueiral.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('479a577f-34df-4cd5-b81c-8a4361380e34', 'e11042be-3d22-4048-9380-ac71e8dc9252', '353e5a99-9085-4402-9029-e55f5d33c810', 1000, '2026-06-19', 'Saldo Meta - BSWave  Maré  BC Cumbuco  Vista Coqueiral.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('5d8878b9-6c62-4b89-a4a0-6fb894dab357', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-19', 'Saldo Meta - BSWave  Maré  BC Cumbuco  Vista Coqueiral', '353e5a99-9085-4402-9029-e55f5d33c810', '479a577f-34df-4cd5-b81c-8a4361380e34', 'Pix', 'Saldo Meta - BSWave  Maré  BC Cumbuco  Vista Coqueiral.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('628e20a5-8bde-49a1-a93e-205325706ea0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - MLar Cambeba  MLar Lago', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-06-19', 'paid', '2026-06-19', 1000, 'Saldo Meta - MLar Cambeba  MLar Lago.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('dd7442d3-0a43-4d86-96d7-e5a25396adf5', 'e11042be-3d22-4048-9380-ac71e8dc9252', '628e20a5-8bde-49a1-a93e-205325706ea0', 1000, '2026-06-19', 'Saldo Meta - MLar Cambeba  MLar Lago.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('f82bb5bd-be12-4c24-b4d5-15ca0318df03', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-19', 'Saldo Meta - MLar Cambeba  MLar Lago', '628e20a5-8bde-49a1-a93e-205325706ea0', 'dd7442d3-0a43-4d86-96d7-e5a25396adf5', 'Pix', 'Saldo Meta - MLar Cambeba  MLar Lago.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('f6be0972-ec20-40bd-a2c0-6dd3f5bdc977', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - La Vie  Inc Parquelândia', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-06-19', 'paid', '2026-06-19', 1000, 'Saldo Meta - La Vie  Inc Parquelândia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('863c7f48-661f-4782-9293-21a3c2fc1ecc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'f6be0972-ec20-40bd-a2c0-6dd3f5bdc977', 1000, '2026-06-19', 'Saldo Meta - La Vie  Inc Parquelândia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('1637347b-1f83-40a0-acc3-03fbc4f658ec', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-19', 'Saldo Meta - La Vie  Inc Parquelândia', 'f6be0972-ec20-40bd-a2c0-6dd3f5bdc977', '863c7f48-661f-4782-9293-21a3c2fc1ecc', 'Pix', 'Saldo Meta - La Vie  Inc Parquelândia.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('6ae237bf-49a7-40fe-b3da-8ec841c4d99a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Pedro', '8b26015a-c9f3-446a-9530-f47757f532da', 250, '2026-06-22', 'paid', '2026-06-22', 250, 'Comissão Pedro.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('7e799733-4bea-488c-a3f1-21ec7919131b', 'e11042be-3d22-4048-9380-ac71e8dc9252', '6ae237bf-49a7-40fe-b3da-8ec841c4d99a', 250, '2026-06-22', 'Comissão Pedro.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('2e8fd70c-877b-47b6-a464-4b86ce5c29d0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 250, '2026-06-22', 'Comissão Pedro', '6ae237bf-49a7-40fe-b3da-8ec841c4d99a', '7e799733-4bea-488c-a3f1-21ec7919131b', 'Pix', 'Comissão Pedro.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('4902e325-d148-4e48-ae2e-0e5483ae6900', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pgto Saldo Google - RE9 Imob - Interior', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 50, '2026-06-22', 'paid', '2026-06-22', 50, 'Pgto Saldo Google - RE9 Imob - Interior.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('84fdecd7-001a-41c2-a9df-d50f529e3f99', 'e11042be-3d22-4048-9380-ac71e8dc9252', '4902e325-d148-4e48-ae2e-0e5483ae6900', 50, '2026-06-22', 'Pgto Saldo Google - RE9 Imob - Interior.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('05e211e8-683d-4bee-96da-d96b376cc321', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 50, '2026-06-22', 'Pgto Saldo Google - RE9 Imob - Interior', '4902e325-d148-4e48-ae2e-0e5483ae6900', '84fdecd7-001a-41c2-a9df-d50f529e3f99', 'Pix', 'Pgto Saldo Google - RE9 Imob - Interior.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('0c34d805-fd92-4b19-9007-a4a86aeea4d2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Interior', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 500, '2026-06-23', 'paid', '2026-06-23', 500, 'Saldo Google - RE9 Imob - Interior.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('cca143d2-6e4c-4122-b94a-36b0180fd5cd', 'e11042be-3d22-4048-9380-ac71e8dc9252', '0c34d805-fd92-4b19-9007-a4a86aeea4d2', 500, '2026-06-23', 'Saldo Google - RE9 Imob - Interior.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('a253a8dd-659a-4acc-8bbb-66fbc7e68923', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-23', 'Saldo Google - RE9 Imob - Interior', '0c34d805-fd92-4b19-9007-a4a86aeea4d2', 'cca143d2-6e4c-4122-b94a-36b0180fd5cd', 'Pix', 'Saldo Google - RE9 Imob - Interior.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('4627cc91-57da-44d5-9809-bb9a8463379c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Fortaleza', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 1000, '2026-06-23', 'paid', '2026-06-23', 1000, 'Saldo Google - RE9 Imob - Fortaleza.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('620476dd-e616-4a7f-8be2-a8dadd479ca4', 'e11042be-3d22-4048-9380-ac71e8dc9252', '4627cc91-57da-44d5-9809-bb9a8463379c', 1000, '2026-06-23', 'Saldo Google - RE9 Imob - Fortaleza.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('d3abadf6-36f7-466a-8520-3feb19c36c28', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-23', 'Saldo Google - RE9 Imob - Fortaleza', '4627cc91-57da-44d5-9809-bb9a8463379c', '620476dd-e616-4a7f-8be2-a8dadd479ca4', 'Pix', 'Saldo Google - RE9 Imob - Fortaleza.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('dfa1a71f-d420-4853-a3b5-4f40554a7fff', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angélica', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 500, '2026-06-29', 'paid', '2026-06-29', 500, 'Pago - Comissão Angélica.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('c6fdd580-9583-46bd-979b-56ead0537f08', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'dfa1a71f-d420-4853-a3b5-4f40554a7fff', 500, '2026-06-29', 'Pago - Comissão Angélica.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('3a90c476-aab5-4dce-8e73-8c518c1c15aa', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-29', 'Comissão Angélica', 'dfa1a71f-d420-4853-a3b5-4f40554a7fff', 'c6fdd580-9583-46bd-979b-56ead0537f08', 'Pix', 'Pago - Comissão Angélica.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('d30dc3a8-0e1e-4091-aa93-00b952ed113f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Creci Assis', 'dda47ddf-192c-41a3-a51c-9764c633bd29', 689, '2026-06-29', 'paid', '2026-06-29', 689, 'Pago - Creci Assis.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('c168f3dd-47fb-4e3f-b495-60aed0f493ec', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'd30dc3a8-0e1e-4091-aa93-00b952ed113f', 689, '2026-06-29', 'Pago - Creci Assis.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('abf56c00-b5ca-4a8d-bc1a-8521d2b54230', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 689, '2026-06-29', 'Creci Assis', 'd30dc3a8-0e1e-4091-aa93-00b952ed113f', 'c168f3dd-47fb-4e3f-b495-60aed0f493ec', 'Pix', 'Pago - Creci Assis.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('8c2ced0d-5cc5-495f-851d-9dd314c2f3e3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 6752.9, '2026-06-29', 'paid', '2026-06-29', 6752.9, 'Pago - Comissão Reno - 29062026.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('4f8f42d7-a5cf-4f29-a7a6-f1931f20d869', 'e11042be-3d22-4048-9380-ac71e8dc9252', '8c2ced0d-5cc5-495f-851d-9dd314c2f3e3', 6752.9, '2026-06-29', 'Pago - Comissão Reno - 29062026.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('dc5b8d17-6123-4e41-ab6c-dd0976e72f4b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 6752.9, '2026-06-29', 'Comissão Reno', '8c2ced0d-5cc5-495f-851d-9dd314c2f3e3', '4f8f42d7-a5cf-4f29-a7a6-f1931f20d869', 'Pix', 'Pago - Comissão Reno - 29062026.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('73dfc349-1486-4820-b146-e780beac25dc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico, Seano, Orizon e Inc Cambeba', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-06-29', 'paid', '2026-06-29', 1000, 'Pago - Saldo Meta - Atlântico, Seano, Orizon e Inc Cambeba.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('755599d2-91ca-40ec-8049-fddb331bdf4d', 'e11042be-3d22-4048-9380-ac71e8dc9252', '73dfc349-1486-4820-b146-e780beac25dc', 1000, '2026-06-29', 'Pago - Saldo Meta - Atlântico, Seano, Orizon e Inc Cambeba.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('cfe401e1-2d7b-4ecc-82d3-e9897dd1b3f9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-29', 'Saldo Meta - Atlântico, Seano, Orizon e Inc Cambeba', '73dfc349-1486-4820-b146-e780beac25dc', '755599d2-91ca-40ec-8049-fddb331bdf4d', 'Pix', 'Pago - Saldo Meta - Atlântico, Seano, Orizon e Inc Cambeba.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('39a1ff6b-f076-498a-844b-3e9c0c8557e6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob - Outros Estados', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 400, '2026-06-30', 'paid', '2026-06-30', 400, 'Saldo Google - RE9 Imob - Outros Estados.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('b9e2af3d-e606-4203-8ef5-c803c090bba2', 'e11042be-3d22-4048-9380-ac71e8dc9252', '39a1ff6b-f076-498a-844b-3e9c0c8557e6', 400, '2026-06-30', 'Saldo Google - RE9 Imob - Outros Estados.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('311be47d-7a0e-41a7-8951-94bac0af39b2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-06-30', 'Saldo Google - Re9 Imob - Outros Estados', '39a1ff6b-f076-498a-844b-3e9c0c8557e6', 'b9e2af3d-e606-4203-8ef5-c803c090bba2', 'Pix', 'Saldo Google - RE9 Imob - Outros Estados.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ca3da35a-d113-41dd-9c4d-1695f3badf32', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob - Interior', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 300, '2026-06-30', 'paid', '2026-06-30', 300, 'Saldo Google - RE9 Imob - Interior (1).jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('f2abe186-cd99-4421-b231-5b79e8c0e267', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ca3da35a-d113-41dd-9c4d-1695f3badf32', 300, '2026-06-30', 'Saldo Google - RE9 Imob - Interior (1).jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('88deba72-526a-441d-a1bd-38fa18a953b4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-06-30', 'Saldo Google - Re9 Imob - Interior', 'ca3da35a-d113-41dd-9c4d-1695f3badf32', 'f2abe186-cd99-4421-b231-5b79e8c0e267', 'Pix', 'Saldo Google - RE9 Imob - Interior (1).jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('3c960965-a1c5-4cd6-937c-251be056a3c1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob - Imoveis Praia', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 400, '2026-06-30', 'paid', '2026-06-30', 400, 'Saldo Google - RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('794ab9a3-b32d-4bb1-b69b-ad48fe94a7b2', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3c960965-a1c5-4cd6-937c-251be056a3c1', 400, '2026-06-30', 'Saldo Google - RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('1f2fe624-9f4e-47c1-b49e-2707d96421fd', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-06-30', 'Saldo Google - Re9 Imob - Imoveis Praia', '3c960965-a1c5-4cd6-937c-251be056a3c1', '794ab9a3-b32d-4bb1-b69b-ad48fe94a7b2', 'Pix', 'Saldo Google - RE9 Imob - Imóveis Praia.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('5d54dba7-f286-4bdc-83d8-ed600b4df8ce', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Fortaleza', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-06-30', 'paid', '2026-06-30', 1000, 'Saldo Google - RE9 Imob - Fortaleza (1).jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('80c823fd-7bd7-41af-b2ac-97bf846a9493', 'e11042be-3d22-4048-9380-ac71e8dc9252', '5d54dba7-f286-4bdc-83d8-ed600b4df8ce', 1000, '2026-06-30', 'Saldo Google - RE9 Imob - Fortaleza (1).jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('aa645765-2b25-4b40-ba81-9f4e17be5ba1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-30', 'Saldo Google - RE9 Imob - Fortaleza', '5d54dba7-f286-4bdc-83d8-ed600b4df8ce', '80c823fd-7bd7-41af-b2ac-97bf846a9493', 'Pix', 'Saldo Google - RE9 Imob - Fortaleza (1).jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('989728db-eb37-4dfa-b4b7-5eff4d42e82a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob - Internacional', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 300, '2026-06-30', 'paid', '2026-06-30', 300, 'Saldo Google - RE9 Imob - Internacional.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('7580268b-497e-4aaa-b99c-22138dd0749f', 'e11042be-3d22-4048-9380-ac71e8dc9252', '989728db-eb37-4dfa-b4b7-5eff4d42e82a', 300, '2026-06-30', 'Saldo Google - RE9 Imob - Internacional.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('b713af44-13f9-4761-846d-d264b720002d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-06-30', 'Saldo Google - Re9 Imob - Internacional', '989728db-eb37-4dfa-b4b7-5eff4d42e82a', '7580268b-497e-4aaa-b99c-22138dd0749f', 'Pix', 'Saldo Google - RE9 Imob - Internacional.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('c093714a-ae26-4788-b5c3-0666e57634a0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bônus Reno', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 1492.05, '2026-07-01', 'paid', '2026-07-01', 1492.05, 'Pago - Bônus Reno.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('bd28a1a1-e124-4b0d-bb42-704d58698313', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c093714a-ae26-4788-b5c3-0666e57634a0', 1492.05, '2026-07-01', 'Pago - Bônus Reno.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('aa9d4d25-ba1b-4061-b562-e3fa1f3088e1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1492.05, '2026-07-01', 'Bônus Reno', 'c093714a-ae26-4788-b5c3-0666e57634a0', 'bd28a1a1-e124-4b0d-bb42-704d58698313', 'Pix', 'Pago - Bônus Reno.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('41d2fdbb-776b-4ef8-b5cc-c532d72bceb8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Captação Assis', 'dda47ddf-192c-41a3-a51c-9764c633bd29', 100, '2026-07-01', 'paid', '2026-07-01', 100, 'Pago - Captação Assis.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('bc2217a5-fe41-43ff-aca0-ee1dd6018ba1', 'e11042be-3d22-4048-9380-ac71e8dc9252', '41d2fdbb-776b-4ef8-b5cc-c532d72bceb8', 100, '2026-07-01', 'Pago - Captação Assis.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('1aafb7ee-350a-4520-8d18-7c620e2fbfeb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 100, '2026-07-01', 'Captação Assis', '41d2fdbb-776b-4ef8-b5cc-c532d72bceb8', 'bc2217a5-fe41-43ff-aca0-ee1dd6018ba1', 'Pix', 'Pago - Captação Assis.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('1ef7169c-2922-40cc-b52b-9a79a8f6c574', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angélica', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 500, '2026-07-01', 'paid', '2026-07-01', 500, 'Pago - Comissão Angélica - 01072026.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2bbe52fa-2ffe-4ce1-a7e2-18727d0075a1', 'e11042be-3d22-4048-9380-ac71e8dc9252', '1ef7169c-2922-40cc-b52b-9a79a8f6c574', 500, '2026-07-01', 'Pago - Comissão Angélica - 01072026.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('b4e3a454-affe-4825-adf4-dfc5b4f9c8f1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-07-01', 'Comissão Angélica', '1ef7169c-2922-40cc-b52b-9a79a8f6c574', '2bbe52fa-2ffe-4ce1-a7e2-18727d0075a1', 'Pix', 'Pago - Comissão Angélica - 01072026.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('4ba26580-f3ef-45da-8c81-f651c7210406', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 13675.72, '2026-07-01', 'paid', '2026-07-01', 13675.72, 'Pago - Comissão Reno - 01072026.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('91d88168-0c9f-4bcf-80f0-9c7878450733', 'e11042be-3d22-4048-9380-ac71e8dc9252', '4ba26580-f3ef-45da-8c81-f651c7210406', 13675.72, '2026-07-01', 'Pago - Comissão Reno - 01072026.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('84dd9013-b5ed-4928-83c5-1b2ea1ecb802', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 13675.72, '2026-07-01', 'Comissão Reno', '4ba26580-f3ef-45da-8c81-f651c7210406', '91d88168-0c9f-4bcf-80f0-9c7878450733', 'Pix', 'Pago - Comissão Reno - 01072026.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('193a05f2-d576-42a6-87f7-bcf007cd2cb0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pagamento dos Chips', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 1500, '2026-07-02', 'paid', '2026-07-02', 1500, 'Pago - Chips.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('6073c303-231a-448d-9b70-81e2d7d4f358', 'e11042be-3d22-4048-9380-ac71e8dc9252', '193a05f2-d576-42a6-87f7-bcf007cd2cb0', 1500, '2026-07-02', 'Pago - Chips.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('46797cca-55ef-4949-aa9a-e838d86ea091', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1500, '2026-07-02', 'Pagamento dos Chips', '193a05f2-d576-42a6-87f7-bcf007cd2cb0', '6073c303-231a-448d-9b70-81e2d7d4f358', 'Pix', 'Pago - Chips.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('c6be8a65-5f81-4abf-aec1-c99d5f7ada10', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Imposto Junho/26', '341f3191-5254-4400-b763-2e3071276044', 6331.53, '2026-07-07', 'paid', '2026-07-07', 6331.53, 'Pago - Impostos Junho.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('430947d9-1c24-4871-9507-48ba2b96ef3a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c6be8a65-5f81-4abf-aec1-c99d5f7ada10', 6331.53, '2026-07-07', 'Pago - Impostos Junho.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('b483ed7f-42dd-4c34-9adf-bb271c0aec86', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 6331.53, '2026-07-07', 'Imposto Junho/26', 'c6be8a65-5f81-4abf-aec1-c99d5f7ada10', '430947d9-1c24-4871-9507-48ba2b96ef3a', 'Pix', 'Pago - Impostos Junho.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('586c18c5-dbb0-4b5c-a377-671380fca44b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Fortaleza', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-07-13', 'paid', '2026-07-13', 1000, 'Saldo Google - RE9 Imob - Fortaleza - 1000.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('05f82fa8-ee0d-4508-95dd-61e271b979d7', 'e11042be-3d22-4048-9380-ac71e8dc9252', '586c18c5-dbb0-4b5c-a377-671380fca44b', 1000, '2026-07-13', 'Saldo Google - RE9 Imob - Fortaleza - 1000.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('ac20fc4b-e605-43b0-91a0-e8e91eb0036e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-07-13', 'Saldo Google - RE9 Imob - Fortaleza', '586c18c5-dbb0-4b5c-a377-671380fca44b', '05f82fa8-ee0d-4508-95dd-61e271b979d7', 'Pix', 'Saldo Google - RE9 Imob - Fortaleza - 1000.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('925a0808-35df-4a94-bba8-4f678382fc4a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Imóveis Praia', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 500, '2026-07-13', 'paid', '2026-07-13', 500, 'Saldo Google - RE9 Imob - Imóveis Praia - 500.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('0fafa57a-1e82-4999-b264-ba73de0595ac', 'e11042be-3d22-4048-9380-ac71e8dc9252', '925a0808-35df-4a94-bba8-4f678382fc4a', 500, '2026-07-13', 'Saldo Google - RE9 Imob - Imóveis Praia - 500.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('60826193-de84-491d-81d0-7c38983f87ef', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-07-13', 'Saldo Google - RE9 Imob - Imóveis Praia', '925a0808-35df-4a94-bba8-4f678382fc4a', '0fafa57a-1e82-4999-b264-ba73de0595ac', 'Pix', 'Saldo Google - RE9 Imob - Imóveis Praia - 500.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('54414a22-ce91-415f-a877-98e604f60804', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Internacional', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 400, '2026-07-13', 'paid', '2026-07-13', 400, 'Saldo Google - RE9 Imob - Internacional - 400.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('084f39be-057a-46b3-91cc-53d54336168f', 'e11042be-3d22-4048-9380-ac71e8dc9252', '54414a22-ce91-415f-a877-98e604f60804', 400, '2026-07-13', 'Saldo Google - RE9 Imob - Internacional - 400.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('e829216d-9d17-43f1-9076-8a20cc8dd7e6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-07-13', 'Saldo Google - RE9 Imob - Internacional', '54414a22-ce91-415f-a877-98e604f60804', '084f39be-057a-46b3-91cc-53d54336168f', 'Pix', 'Saldo Google - RE9 Imob - Internacional - 400.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('bdad4068-e17f-4485-a125-aa98e163b0e0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Outros Estados', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 400, '2026-07-13', 'paid', '2026-07-13', 400, 'Saldo Google - RE9 Imob - Outros Estados - 400.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('09d7bfcf-591f-4397-8ac3-3045e14ea20e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'bdad4068-e17f-4485-a125-aa98e163b0e0', 400, '2026-07-13', 'Saldo Google - RE9 Imob - Outros Estados - 400.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('d06e3ea5-59ca-403b-9de8-105dcabaa45f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-07-13', 'Saldo Google - RE9 Imob - Outros Estados', 'bdad4068-e17f-4485-a125-aa98e163b0e0', '09d7bfcf-591f-4397-8ac3-3045e14ea20e', 'Pix', 'Saldo Google - RE9 Imob - Outros Estados - 400.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('4d36ca25-09ac-4eeb-9b31-df2bda1ffe70', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Adiantamento Quinzenal', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 1250, '2026-07-14', 'paid', '2026-07-14', 1250, 'Pago - Adiantamento Quinzenal.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('8a44aa8c-7914-45fb-9970-0ce3cf6da977', 'e11042be-3d22-4048-9380-ac71e8dc9252', '4d36ca25-09ac-4eeb-9b31-df2bda1ffe70', 1250, '2026-07-14', 'Pago - Adiantamento Quinzenal.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('102736c1-d132-464f-ae2d-fbc37afec775', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1250, '2026-07-14', 'Adiantamento Quinzenal', '4d36ca25-09ac-4eeb-9b31-df2bda1ffe70', '8a44aa8c-7914-45fb-9970-0ce3cf6da977', 'Pix', 'Pago - Adiantamento Quinzenal.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('fb51d607-613c-4cf3-8cb3-37088ad53b37', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 15163.36, '2026-07-14', 'paid', '2026-07-14', 15163.36, 'Pago - Comissão Reno 15k.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('605e511d-63cd-4fe6-b709-77ea8342afa8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'fb51d607-613c-4cf3-8cb3-37088ad53b37', 15163.36, '2026-07-14', 'Pago - Comissão Reno 15k.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('dd260a3f-887e-4c86-bc10-565dcc11ac80', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 15163.36, '2026-07-14', 'Comissão Reno', 'fb51d607-613c-4cf3-8cb3-37088ad53b37', '605e511d-63cd-4fe6-b709-77ea8342afa8', 'Pix', 'Pago - Comissão Reno 15k.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('28908049-d71c-4d65-b682-c63b4e5fa580', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 12977.11, '2026-07-20', 'paid', '2026-07-20', 12977.11, 'Pago - Comissão Reno 12k.jpegg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('e982e082-43a8-411f-8a08-30701d32de1b', 'e11042be-3d22-4048-9380-ac71e8dc9252', '28908049-d71c-4d65-b682-c63b4e5fa580', 12977.11, '2026-07-20', 'Pago - Comissão Reno 12k.jpegg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('4e8177f5-63b5-435e-8816-d7f41ef9c77b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 12977.11, '2026-07-20', 'Comissão Reno', '28908049-d71c-4d65-b682-c63b4e5fa580', 'e982e082-43a8-411f-8a08-30701d32de1b', 'Pix', 'Pago - Comissão Reno 12k.jpegg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('1166081d-7d28-4ab7-8cd4-f119cd28a3ae', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angélica', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 500, '2026-07-20', 'paid', '2026-07-20', 500, 'Pago - Comissão Angélica 1.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('446bc488-821c-4599-9910-4233b8e10336', 'e11042be-3d22-4048-9380-ac71e8dc9252', '1166081d-7d28-4ab7-8cd4-f119cd28a3ae', 500, '2026-07-20', 'Pago - Comissão Angélica 1.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('79568795-a886-46de-915d-f44ba25c72cf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-07-20', 'Comissão Angélica', '1166081d-7d28-4ab7-8cd4-f119cd28a3ae', '446bc488-821c-4599-9910-4233b8e10336', 'Pix', 'Pago - Comissão Angélica 1.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('50015b10-0e49-476b-9873-d1d66221c7f5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Serviço Financeiro', '71aa990e-85e6-4fff-b79d-7e5aac40a20d', 1500, '2026-07-20', 'paid', '2026-07-20', 1500, 'Pago - Pagamento para Nummis.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('96fd01d2-96b1-44a3-b029-abd09be2aee3', 'e11042be-3d22-4048-9380-ac71e8dc9252', '50015b10-0e49-476b-9873-d1d66221c7f5', 1500, '2026-07-20', 'Pago - Pagamento para Nummis.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('c6ed6a48-c1d0-4db5-9cce-ec0f59d9f4b6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1500, '2026-07-20', 'Serviço Financeiro', '50015b10-0e49-476b-9873-d1d66221c7f5', '96fd01d2-96b1-44a3-b029-abd09be2aee3', 'Pix', 'Pago - Pagamento para Nummis.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('6bb90b3d-3325-4c85-b844-ca06c6e11513', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 4371.37, '2026-07-20', 'paid', '2026-07-20', 4371.37, 'Pago - Comissão Reno 4k.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('8448306a-d9d3-4cf0-810b-488ac48904e1', 'e11042be-3d22-4048-9380-ac71e8dc9252', '6bb90b3d-3325-4c85-b844-ca06c6e11513', 4371.37, '2026-07-20', 'Pago - Comissão Reno 4k.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('b52228ec-896d-46e5-a4bd-21b3a66176e4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 4371.37, '2026-07-20', 'Comissão Reno', '6bb90b3d-3325-4c85-b844-ca06c6e11513', '8448306a-d9d3-4cf0-810b-488ac48904e1', 'Pix', 'Pago - Comissão Reno 4k.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('cf5aa5cb-cb98-455a-8ce6-fc8951c329f3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angélica', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 500, '2026-07-20', 'paid', '2026-07-20', 500, 'Pago - Comissão Angélica 2.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('f75ec703-3e0e-4a58-b89b-097df1e4665c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'cf5aa5cb-cb98-455a-8ce6-fc8951c329f3', 500, '2026-07-20', 'Pago - Comissão Angélica 2.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('5706f53b-9714-4d91-b248-5c418df9d76e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-07-20', 'Comissão Angélica', 'cf5aa5cb-cb98-455a-8ce6-fc8951c329f3', 'f75ec703-3e0e-4a58-b89b-097df1e4665c', 'Pix', 'Pago - Comissão Angélica 2.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('e941f101-d4ed-4165-9b18-3ec52f72da0d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Contabilidade', 'a4c8fd3c-922c-40c0-9931-c3874ce50de8', 300, '2026-07-20', 'paid', '2026-07-20', 300, 'Pago - Comissão Contabilidade.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('fa427369-e73a-4590-8458-893e7f4c2f35', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'e941f101-d4ed-4165-9b18-3ec52f72da0d', 300, '2026-07-20', 'Pago - Comissão Contabilidade.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('0da5fd6c-a189-4cb3-bf48-44fea30dbe0f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-07-20', 'Comissão Contabilidade', 'e941f101-d4ed-4165-9b18-3ec52f72da0d', 'fa427369-e73a-4590-8458-893e7f4c2f35', 'Pix', 'Pago - Comissão Contabilidade.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('7437f1bb-54c6-4af7-bff5-6d49b7b14e00', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Bella Aldeota, Bella Rio, Oasy e Myrage', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 2000, '2026-07-20', 'paid', '2026-07-20', 2000, 'Pago - Saldo Meta - Bella Aldeota, Bella Rio, Oasy e Myrage.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('7af5c858-ec88-4977-b3d0-daa41bf7eb05', 'e11042be-3d22-4048-9380-ac71e8dc9252', '7437f1bb-54c6-4af7-bff5-6d49b7b14e00', 2000, '2026-07-20', 'Pago - Saldo Meta - Bella Aldeota, Bella Rio, Oasy e Myrage.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('0bd7a33b-fbcd-4511-98da-436c17173379', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2000, '2026-07-20', 'Saldo Meta - Bella Aldeota, Bella Rio, Oasy e Myrage', '7437f1bb-54c6-4af7-bff5-6d49b7b14e00', '7af5c858-ec88-4977-b3d0-daa41bf7eb05', 'Pix', 'Pago - Saldo Meta - Bella Aldeota, Bella Rio, Oasy e Myrage.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('0b14b32f-ed96-4e67-829d-d75de2e23892', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Mlar Cambeba, Lago e Inc', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1500, '2026-07-20', 'paid', '2026-07-20', 1500, 'Pago - Saldo Meta - Mlar Cambeba, Lago e Inc.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('292fbb13-38ed-4f5c-b49c-64148a345ef9', 'e11042be-3d22-4048-9380-ac71e8dc9252', '0b14b32f-ed96-4e67-829d-d75de2e23892', 1500, '2026-07-20', 'Pago - Saldo Meta - Mlar Cambeba, Lago e Inc.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('681121fe-a510-4d6d-b6dd-300610aafca6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1500, '2026-07-20', 'Saldo Meta - Mlar Cambeba, Lago e Inc', '0b14b32f-ed96-4e67-829d-d75de2e23892', '292fbb13-38ed-4f5c-b49c-64148a345ef9', 'Pix', 'Pago - Saldo Meta - Mlar Cambeba, Lago e Inc.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('4f784740-2de8-47f5-9028-dc7f38629418', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob Fortaleza', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 1000, '2026-07-20', 'paid', '2026-07-20', 1000, 'Pago - Saldo Google - Re9 Imob Fortaleza.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('cc6e09a6-c6ba-4a25-b8fa-3867be88be06', 'e11042be-3d22-4048-9380-ac71e8dc9252', '4f784740-2de8-47f5-9028-dc7f38629418', 1000, '2026-07-20', 'Pago - Saldo Google - Re9 Imob Fortaleza.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('ace6814f-8260-4846-954d-4a605e35deb6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-07-20', 'Saldo Google - Re9 Imob Fortaleza', '4f784740-2de8-47f5-9028-dc7f38629418', 'cc6e09a6-c6ba-4a25-b8fa-3867be88be06', 'Pix', 'Pago - Saldo Google - Re9 Imob Fortaleza.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('63cb05b4-cd44-4539-bf95-42c87033a7a3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob Interior', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 300, '2026-07-20', 'paid', '2026-07-20', 300, 'Pago - Saldo Google - Re9 Imob Interior.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('08780e73-b360-4ce2-908c-af8fe53e597c', 'e11042be-3d22-4048-9380-ac71e8dc9252', '63cb05b4-cd44-4539-bf95-42c87033a7a3', 300, '2026-07-20', 'Pago - Saldo Google - Re9 Imob Interior.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('acf0c801-2bd6-4664-94e6-ceffca130b0b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-07-20', 'Saldo Google - Re9 Imob Interior', '63cb05b4-cd44-4539-bf95-42c87033a7a3', '08780e73-b360-4ce2-908c-af8fe53e597c', 'Pix', 'Pago - Saldo Google - Re9 Imob Interior.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('0e610daa-1468-42ce-af27-1d9f44cde3c2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob Outros Estados', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 400, '2026-07-20', 'paid', '2026-07-20', 400, 'Pago - Saldo Google - Re9 Imob Outros Estados.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('1a3198c0-3419-4a06-bf6d-76cc56ca6737', 'e11042be-3d22-4048-9380-ac71e8dc9252', '0e610daa-1468-42ce-af27-1d9f44cde3c2', 400, '2026-07-20', 'Pago - Saldo Google - Re9 Imob Outros Estados.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('afa2b21f-e7f4-4156-8f13-49997004b0c5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-07-20', 'Saldo Google - Re9 Imob Outros Estados', '0e610daa-1468-42ce-af27-1d9f44cde3c2', '1a3198c0-3419-4a06-bf6d-76cc56ca6737', 'Pix', 'Pago - Saldo Google - Re9 Imob Outros Estados.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('3c938c8c-c028-43bc-b66d-e3f797d71762', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pagamento OLX', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 275.9, '2026-07-28', 'paid', '2026-07-28', 275.9, 'Pago - OLX.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2a4d401b-2158-47f5-955f-67252e6b5926', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3c938c8c-c028-43bc-b66d-e3f797d71762', 275.9, '2026-07-28', 'Pago - OLX.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('df0df58f-08a7-48a3-bd7f-ffb9ad6b606b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 275.9, '2026-07-28', 'Pagamento OLX', '3c938c8c-c028-43bc-b66d-e3f797d71762', '2a4d401b-2158-47f5-955f-67252e6b5926', 'Pix', 'Pago - OLX.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('fd9576e3-cfad-4699-a02f-86094d51af36', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google 500 - RE9 Imob - Outros Estados', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 500, '2026-07-29', 'paid', '2026-07-29', 500, 'Pago - Saldo Google 500 - RE9 Imob - Outros Estados.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('58239315-bac3-4ebd-8c28-21e1432d28d3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'fd9576e3-cfad-4699-a02f-86094d51af36', 500, '2026-07-29', 'Pago - Saldo Google 500 - RE9 Imob - Outros Estados.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('66527a83-8752-4c6b-80e4-c30caaa886fe', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-07-29', 'Saldo Google 500 - RE9 Imob - Outros Estados', 'fd9576e3-cfad-4699-a02f-86094d51af36', '58239315-bac3-4ebd-8c28-21e1432d28d3', 'Pix', 'Pago - Saldo Google 500 - RE9 Imob - Outros Estados.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('0248cfa5-5b3e-49b3-b929-c1d88a8fa052', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta 2000 - Bella Aldeota, Rio, Oasy e Myrage', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 2000, '2026-07-29', 'paid', '2026-07-29', 2000, 'Pago - Saldo Meta 2000 - Bella Aldeota, Rio, Oasy e Myrage.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('ee20aa8d-107b-453a-990a-6232bffad3cb', 'e11042be-3d22-4048-9380-ac71e8dc9252', '0248cfa5-5b3e-49b3-b929-c1d88a8fa052', 2000, '2026-07-29', 'Pago - Saldo Meta 2000 - Bella Aldeota, Rio, Oasy e Myrage.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('69db4c9e-02ab-41a7-9b70-039a14a15949', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2000, '2026-07-29', 'Saldo Meta 2000 - Bella Aldeota, Rio, Oasy e Myrage', '0248cfa5-5b3e-49b3-b929-c1d88a8fa052', 'ee20aa8d-107b-453a-990a-6232bffad3cb', 'Pix', 'Pago - Saldo Meta 2000 - Bella Aldeota, Rio, Oasy e Myrage.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('e6074b9e-89c2-44e2-aa95-875d73ade9bd', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta 1000 - MLar Cambeba, Lago e Inc Cambeba', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-07-29', 'paid', '2026-07-29', 1000, 'Pago - Saldo Meta 1000 - MLar Cambeba, Lago e Inc Cambeba.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('feac9df4-d300-4087-b3a4-d25b65d6db85', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'e6074b9e-89c2-44e2-aa95-875d73ade9bd', 1000, '2026-07-29', 'Pago - Saldo Meta 1000 - MLar Cambeba, Lago e Inc Cambeba.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('743c7f4f-4a4b-4603-b3e2-8324108eede5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-07-29', 'Saldo Meta 1000 - MLar Cambeba, Lago e Inc Cambeba', 'e6074b9e-89c2-44e2-aa95-875d73ade9bd', 'feac9df4-d300-4087-b3a4-d25b65d6db85', 'Pix', 'Pago - Saldo Meta 1000 - MLar Cambeba, Lago e Inc Cambeba.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('cfe2924b-90e3-479d-ad7f-91058a2713f9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta 2000 - Maré, BS Wave e Vista Coqueiral', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 2000, '2026-07-29', 'paid', '2026-07-29', 2000, 'Pago - Saldo Meta 2000 - Maré, BS Wave e Vista Coqueiral.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('4dc629d3-0561-406b-84b1-c1ce6668f583', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'cfe2924b-90e3-479d-ad7f-91058a2713f9', 2000, '2026-07-29', 'Pago - Saldo Meta 2000 - Maré, BS Wave e Vista Coqueiral.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('aba32563-2d20-4043-b1b9-38dd0715e18b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2000, '2026-07-29', 'Saldo Meta 2000 - Maré, BS Wave e Vista Coqueiral', 'cfe2924b-90e3-479d-ad7f-91058a2713f9', '4dc629d3-0561-406b-84b1-c1ce6668f583', 'Pix', 'Pago - Saldo Meta 2000 - Maré, BS Wave e Vista Coqueiral.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('728c9f1a-92fe-4f7f-9460-4d97ccb6756b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta 1000 - La Vie e Inc Parquelândia', '43a127e1-24fd-4f56-8ad9-8e49939965c8', 1000, '2026-07-29', 'paid', '2026-07-29', 1000, 'Pago - Saldo Meta 1000 - La Vie e Inc Parquelândia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2d2e8962-e3a8-44ca-8f37-a7649265fb2d', 'e11042be-3d22-4048-9380-ac71e8dc9252', '728c9f1a-92fe-4f7f-9460-4d97ccb6756b', 1000, '2026-07-29', 'Pago - Saldo Meta 1000 - La Vie e Inc Parquelândia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('977124cc-0a02-40c5-9362-62d7a6e83114', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-07-29', 'Saldo Meta 1000 - La Vie e Inc Parquelândia', '728c9f1a-92fe-4f7f-9460-4d97ccb6756b', '2d2e8962-e3a8-44ca-8f37-a7649265fb2d', 'Pix', 'Pago - Saldo Meta 1000 - La Vie e Inc Parquelândia.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('c2c6583a-4d10-45b8-9760-3bc67b67ec48', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google 2000 - RE9 Imob - Fortaleza', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 2000, '2026-07-29', 'paid', '2026-07-29', 2000, 'Pago - Saldo Google 2000 - RE9 Imob - Fortaleza.jpegg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('287a39fa-83e7-46d0-b64e-1d27a6223b76', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c2c6583a-4d10-45b8-9760-3bc67b67ec48', 2000, '2026-07-29', 'Pago - Saldo Google 2000 - RE9 Imob - Fortaleza.jpegg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('e92973f4-50ee-498e-a83f-f7c5a35e015f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2000, '2026-07-29', 'Saldo Google 2000 - RE9 Imob - Fortaleza', 'c2c6583a-4d10-45b8-9760-3bc67b67ec48', '287a39fa-83e7-46d0-b64e-1d27a6223b76', 'Pix', 'Pago - Saldo Google 2000 - RE9 Imob - Fortaleza.jpegg');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('68869003-6669-411f-af2b-51e870aa5d79', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google 1000 - RE9 Imob - Imóveis Praia', '550e7f95-39e9-4c1e-843a-41fb79f962fa', 1000, '2026-07-29', 'paid', '2026-07-29', 1000, 'Pago - Saldo Google 1000 - RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('ed7709f7-9a5f-4e17-963b-608b65933c22', 'e11042be-3d22-4048-9380-ac71e8dc9252', '68869003-6669-411f-af2b-51e870aa5d79', 1000, '2026-07-29', 'Pago - Saldo Google 1000 - RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, settlement_id, payment_method, proof_url)
    VALUES ('4a966195-6c2a-49ac-ac88-f7ee4163a4e2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-07-29', 'Saldo Google 1000 - RE9 Imob - Imóveis Praia', '68869003-6669-411f-af2b-51e870aa5d79', 'ed7709f7-9a5f-4e17-963b-608b65933c22', 'Pix', 'Pago - Saldo Google 1000 - RE9 Imob - Imóveis Praia.jpeg');
  
COMMIT;