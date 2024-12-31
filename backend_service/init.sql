create table if not exists slots (
    id serial primary key not null,
    start_date timestamptz not null,
    end_date timestamptz not null,
    booked boolean not null default false,
    booked_by varchar(250) null
);

insert into slots (start_date, end_date, booked, booked_by) 
values ('2024-05-01T09:00:00.000Z', '2024-05-01T10:00:00.000Z', false, NULL),
    ('2024-05-01T10:00:00.000Z', '2024-05-01T11:00:00.000Z', true, 'Customer 1'),
    ('2024-05-01T11:00:00.000Z', '2024-05-01T12:00:00.000Z', false, NULL),
    ('2024-05-01T14:30:00.000Z', '2024-05-01T15:30:00.000Z', false, NULL),
    ('2024-05-01T15:30:00.000Z', '2024-05-01T16:30:00.000Z', false, NULL),
    ('2024-05-02T09:00:00.000Z', '2024-05-02T10:00:00.000Z', false, NULL),
    ('2024-05-02T11:00:00.000Z', '2024-05-02T12:00:00.000Z', false, NULL),
    ('2024-05-02T12:00:00.000Z', '2024-05-02T13:00:00.000Z', false, NULL),
    ('2024-05-02T16:00:00.000Z', '2024-05-02T17:00:00.000Z', false, NULL),
    ('2024-05-03T09:00:00.000Z', '2024-05-03T10:00:00.000Z', true, 'Customer 2'),
    ('2024-05-03T10:00:00.000Z', '2024-05-03T11:00:00.000Z', false, NULL),
    ('2024-05-03T11:00:00.000Z', '2024-05-03T12:00:00.000Z', false, NULL),
    ('2024-05-03T12:00:00.000Z', '2024-05-03T13:00:00.000Z', false, NULL),
    ('2024-05-03T13:00:00.000Z', '2024-05-03T14:00:00.000Z', true, 'Customer 3'),
    ('2024-05-03T14:00:00.000Z', '2024-05-03T15:00:00.000Z', false, NULL),
    ('2024-05-04T09:30:00.000Z', '2024-05-03T10:30:00.000Z', false, NULL),
    ('2024-05-04T12:30:00.000Z', '2024-05-03T13:30:00.000Z', false, NULL),
    ('2024-05-04T14:30:00.000Z', '2024-05-03T15:30:00.000Z', false, NULL),
    ('2024-05-04T16:00:00.000Z', '2024-05-03T17:00:00.000Z', false, NULL);
