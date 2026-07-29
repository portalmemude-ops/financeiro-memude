BEGIN;

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('324d6a2b-8df3-40c7-8801-e07a2bdbe982', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão 3 Vendas Soraya (Vista di Mari 1303, 1213 / MLar Cambeba 705) — Pt1', 'Vista di Mari', 5655.57, '2026-04-18', 'received', '2026-04-18', 5655.57, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('1d7af4eb-6dec-4409-8775-63cfc291855d', 'e11042be-3d22-4048-9380-ac71e8dc9252', '324d6a2b-8df3-40c7-8801-e07a2bdbe982', 5655.57, '2026-04-18');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('ffb69bf8-6550-40af-a76b-5ee4bc29be89', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 5655.57, '2026-04-18', 'Comissão 3 Vendas Soraya (Vista di Mari 1303, 1213 / MLar Cambeba 705) — Pt1', '324d6a2b-8df3-40c7-8801-e07a2bdbe982', '1d7af4eb-6dec-4409-8775-63cfc291855d', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('6a14b9bb-2aa6-4a74-bc34-97ece5922e8e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão 3 Vendas Soraya (Vista di Mari 1303, 1213 / MLar Cambeba 705) — Pt2', 'Vista di Mari', 4891, '2026-04-23', 'received', '2026-04-23', 4891, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('a34506bf-6af7-4764-9a8a-7a222e2b25f7', 'e11042be-3d22-4048-9380-ac71e8dc9252', '6a14b9bb-2aa6-4a74-bc34-97ece5922e8e', 4891, '2026-04-23');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('87b339cc-49d5-457c-946e-dbd2e4d6ec50', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 4891, '2026-04-23', 'Comissão 3 Vendas Soraya (Vista di Mari 1303, 1213 / MLar Cambeba 705) — Pt2', '6a14b9bb-2aa6-4a74-bc34-97ece5922e8e', 'a34506bf-6af7-4764-9a8a-7a222e2b25f7', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('7a706c7d-794a-4db7-a2cb-8f368bc71edf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Aporte Reno', 'Reno', 5000, '2026-04-30', 'received', '2026-04-30', 5000, 'Aporte sócio');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('9db681a3-10e5-49c6-a756-7ae05ec4dbfb', 'e11042be-3d22-4048-9380-ac71e8dc9252', '7a706c7d-794a-4db7-a2cb-8f368bc71edf', 5000, '2026-04-30');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('0f51068f-cb10-4478-b7e3-5f78a80d75eb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 5000, '2026-04-30', 'Aporte Reno', '7a706c7d-794a-4db7-a2cb-8f368bc71edf', '9db681a3-10e5-49c6-a756-7ae05ec4dbfb', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('c7c4dc42-6226-4632-9c40-4dc1229e0ad2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Vibe Meireles Ap. 2103', 'Vibe Meireles', 24006.42, '2026-05-05', 'received', '2026-05-05', 24006.42, 'Corretor: Reno');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('9456df07-b885-434d-84ea-ce786b687b7b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c7c4dc42-6226-4632-9c40-4dc1229e0ad2', 24006.42, '2026-05-05');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('5eecfa57-a58a-41ac-a429-75e49b97e1c8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 24006.42, '2026-05-05', 'Comissão Venda Reno — Vibe Meireles Ap. 2103', 'c7c4dc42-6226-4632-9c40-4dc1229e0ad2', '9456df07-b885-434d-84ea-ce786b687b7b', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('c2865e9a-b09e-4499-a521-1fba8eec64f6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bonus Venda Reno — Bella Aldeota (Mateus J.)', 'Bella Aldeota', 2990.57, '2026-05-18', 'received', '2026-05-18', 2990.57, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('425ac7b0-4df3-4d89-af6c-3e8c68693060', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c2865e9a-b09e-4499-a521-1fba8eec64f6', 2990.57, '2026-05-18');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('d7878de5-db29-4609-aaa0-2ba213411533', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 2990.57, '2026-05-18', 'Bonus Venda Reno — Bella Aldeota (Mateus J.)', 'c2865e9a-b09e-4499-a521-1fba8eec64f6', '425ac7b0-4df3-4d89-af6c-3e8c68693060', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('3ad06eb2-9ace-4af9-9415-ba91192b96c7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Bella Aldeota (Mateus J.)', 'Bella Aldeota', 10800.53, '2026-05-18', 'received', '2026-05-18', 10800.53, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('1bad0553-cf6c-42a0-8bb1-2248708aebe6', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3ad06eb2-9ace-4af9-9415-ba91192b96c7', 10800.53, '2026-05-18');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('70ed01e8-9f93-46a6-8024-cddbb36ed17e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 10800.53, '2026-05-18', 'Comissão Venda Reno — Bella Aldeota (Mateus J.)', '3ad06eb2-9ace-4af9-9415-ba91192b96c7', '1bad0553-cf6c-42a0-8bb1-2248708aebe6', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('946dbc25-ddf0-4278-998d-378959942ca1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno - Maré - Beatriz', 'Maré', 29365.41, '2026-05-18', 'received', '2026-05-18', 29365.41, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('17ccd7ce-6a5e-4cfa-8909-c9736ef42fe9', 'e11042be-3d22-4048-9380-ac71e8dc9252', '946dbc25-ddf0-4278-998d-378959942ca1', 29365.41, '2026-05-18');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('7737e132-f25f-4ec6-80a7-cacff4c600fb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 29365.41, '2026-05-18', 'Comissão Venda Reno - Maré - Beatriz', '946dbc25-ddf0-4278-998d-378959942ca1', '17ccd7ce-6a5e-4cfa-8909-c9736ef42fe9', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('02933237-7f8a-49c8-a9f1-f79b009256f2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno - MLar Kennedy - Lia e Jonathan', 'MLar Kennedy', 14933.56, '2026-06-18', 'received', '2026-06-18', 14933.56, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('3458a1ed-0f79-464c-a480-61d95491cc4a', 'e11042be-3d22-4048-9380-ac71e8dc9252', '02933237-7f8a-49c8-a9f1-f79b009256f2', 14933.56, '2026-06-18');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('f3fc814b-3c18-47bc-9d6a-0e0a2bc18cf3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 14933.56, '2026-06-18', 'Comissão Venda Reno - MLar Kennedy - Lia e Jonathan', '02933237-7f8a-49c8-a9f1-f79b009256f2', '3458a1ed-0f79-464c-a480-61d95491cc4a', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('8278e1e9-d804-4f78-a388-be2bc813cfa3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno - MLar  - Rafael Herminio', 'Mlar Jacarey', 13505.8, '2026-06-23', 'received', '2026-06-23', 13505.8, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('4a0f763c-55f7-40a5-8d15-5e8cd7389463', 'e11042be-3d22-4048-9380-ac71e8dc9252', '8278e1e9-d804-4f78-a388-be2bc813cfa3', 13505.8, '2026-06-23');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('72214332-e6b3-40b9-a2d8-9153ec080fe8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 13505.8, '2026-06-23', 'Comissão Venda Reno - MLar  - Rafael Herminio', '8278e1e9-d804-4f78-a388-be2bc813cfa3', '4a0f763c-55f7-40a5-8d15-5e8cd7389463', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('f587ef6b-4b01-4491-aa26-b95426ca5091', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bonus Venda Reno - MLar Kennedy - Lia e Jonathan', 'MLar Kennedy', 2894.1, '2026-07-01', 'received', '2026-07-01', 2894.1, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('5b567bb7-9c79-4b94-b70b-af007ec8151a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'f587ef6b-4b01-4491-aa26-b95426ca5091', 2894.1, '2026-07-01');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('218ba919-31ae-4c92-9f8e-4da658551f72', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 2894.1, '2026-07-01', 'Bonus Venda Reno - MLar Kennedy - Lia e Jonathan', 'f587ef6b-4b01-4491-aa26-b95426ca5091', '5b567bb7-9c79-4b94-b70b-af007ec8151a', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('377d2e8f-5f2e-431b-92cd-0287e5be55e4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno - Gilson - Beatriz', 'Maré', 27351.44, '2026-06-01', 'received', '2026-06-01', 27351.44, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('6ca2b268-f068-4b33-9585-4bba736f6540', 'e11042be-3d22-4048-9380-ac71e8dc9252', '377d2e8f-5f2e-431b-92cd-0287e5be55e4', 27351.44, '2026-06-01');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('74907910-db7c-4158-8f07-dbf78d7b8bb6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 27351.44, '2026-06-01', 'Comissão Venda Reno - Gilson - Beatriz', '377d2e8f-5f2e-431b-92cd-0287e5be55e4', '6ca2b268-f068-4b33-9585-4bba736f6540', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('61a72b0a-3d1a-41ed-a05f-7a46e01d1250', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Bella Aldeota', 'Bella Aldeota', 19526.19, '2026-07-13', 'received', '2026-07-13', 19526.19, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('32a4a2cf-9c51-411e-8d6d-a87788037568', 'e11042be-3d22-4048-9380-ac71e8dc9252', '61a72b0a-3d1a-41ed-a05f-7a46e01d1250', 19526.19, '2026-07-13');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('da880484-cdd8-449a-a07a-11d6510e51e2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 19526.19, '2026-07-13', 'Comissão Venda Reno — Bella Aldeota', '61a72b0a-3d1a-41ed-a05f-7a46e01d1250', '32a4a2cf-9c51-411e-8d6d-a87788037568', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('3499a116-98e5-4507-9f11-358956cd73e3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Bella Aldeota (Mateus J.)', 'Bella Aldeota', 10800.53, '2026-07-13', 'received', '2026-07-13', 10800.53, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('3e423104-44bf-4f4e-90af-bead3b450363', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3499a116-98e5-4507-9f11-358956cd73e3', 10800.53, '2026-07-13');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('2a089d15-0fe2-4ebc-9f11-aa6c4cc96d99', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 10800.53, '2026-07-13', 'Comissão Venda Reno — Bella Aldeota (Mateus J.)', '3499a116-98e5-4507-9f11-358956cd73e3', '3e423104-44bf-4f4e-90af-bead3b450363', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('cb98bd40-97f2-4ce2-989f-2f55e04c1f18', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Maré (Mara)', 'Maré', 25038.04, '2026-07-13', 'received', '2026-07-13', 25038.04, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('5b495843-9b76-48cc-bc35-cc9a1bceafdf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'cb98bd40-97f2-4ce2-989f-2f55e04c1f18', 25038.04, '2026-07-13');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('80172167-b949-4483-addb-99f610b0e585', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 25038.04, '2026-07-13', 'Comissão Venda Reno — Maré (Mara)', 'cb98bd40-97f2-4ce2-989f-2f55e04c1f18', '5b495843-9b76-48cc-bc35-cc9a1bceafdf', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('af879a75-0451-4d93-96f3-59d30e3678eb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Bella Aldeota (Jaime)', 'Bella Aldeota', 17485.5, '2026-07-20', 'received', '2026-07-20', 17485.5, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('53f4b3bb-c04b-4721-b332-58c8e589bc39', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'af879a75-0451-4d93-96f3-59d30e3678eb', 17485.5, '2026-07-20');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('d3d30026-f861-4afa-99da-e010907e2323', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 17485.5, '2026-07-20', 'Comissão Venda Reno — Bella Aldeota (Jaime)', 'af879a75-0451-4d93-96f3-59d30e3678eb', '53f4b3bb-c04b-4721-b332-58c8e589bc39', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('085f92af-7032-4c04-9998-34036d01d803', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Investimento Tráfego - PraMorar', 'Bella Aldeota', 1900, '2026-07-20', 'received', '2026-07-20', 1900, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('e70b3c7f-a2c5-4218-86eb-aaa63c736fad', 'e11042be-3d22-4048-9380-ac71e8dc9252', '085f92af-7032-4c04-9998-34036d01d803', 1900, '2026-07-20');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('5146f5db-a1f8-4c0c-a792-9348abf65b7e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 1900, '2026-07-20', 'Investimento Tráfego - PraMorar', '085f92af-7032-4c04-9998-34036d01d803', 'e70b3c7f-a2c5-4218-86eb-aaa63c736fad', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('242117b7-e4b2-4ba2-8292-6f4495c535c4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Viva Vida', 'Viva Vida Sul', 5788.2, '2026-07-21', 'received', '2026-07-21', 5788.2, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('c8cf93b7-acfa-41e8-89b9-54e4c71f5087', 'e11042be-3d22-4048-9380-ac71e8dc9252', '242117b7-e4b2-4ba2-8292-6f4495c535c4', 5788.2, '2026-07-21');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('21c4f307-8a86-43aa-b67a-af4e00fdcb4b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 5788.2, '2026-07-21', 'Comissão Viva Vida', '242117b7-e4b2-4ba2-8292-6f4495c535c4', 'c8cf93b7-acfa-41e8-89b9-54e4c71f5087', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('8b0b11f6-0908-4498-9164-fa51b067ff1b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bella Aldeota - Investimento', 'Bella Aldeota', 1929.4, '2026-07-27', 'received', '2026-07-27', 1929.4, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('d59f995a-c47b-43af-925c-b2112712c862', 'e11042be-3d22-4048-9380-ac71e8dc9252', '8b0b11f6-0908-4498-9164-fa51b067ff1b', 1929.4, '2026-07-27');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('45b74207-d248-4696-bb7c-01fe49439c27', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 1929.4, '2026-07-27', 'Bella Aldeota - Investimento', '8b0b11f6-0908-4498-9164-fa51b067ff1b', 'd59f995a-c47b-43af-925c-b2112712c862', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('233fcf50-4b74-4c7d-b480-ad756b986da4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bonus - Gilson', 'Bella Aldeota', 9647, '2026-07-27', 'received', '2026-07-27', 9647, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('27b0b457-7a63-4a76-a349-4244015c0fc8', 'e11042be-3d22-4048-9380-ac71e8dc9252', '233fcf50-4b74-4c7d-b480-ad756b986da4', 9647, '2026-07-27');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, settlement_id, payment_method)
    VALUES ('d121db9a-2e29-41c7-bb47-8fd8049dcd82', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 9647, '2026-07-27', 'Bonus - Gilson', '233fcf50-4b74-4c7d-b480-ad756b986da4', '27b0b457-7a63-4a76-a349-4244015c0fc8', 'Pix');
  
COMMIT;