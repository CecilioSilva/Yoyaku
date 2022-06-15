// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_model.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Item extends DataClass implements Insertable<Item> {
  final int id;
  final String uuid;
  final int type;
  final String title;
  final DateTime dateBought;
  final DateTime releaseDate;
  final String currency;
  final double price;
  final double shipping;
  final Uint8List image;
  final String link;
  final bool delivered;
  final bool import;
  final bool paid;
  final bool canceled;
  final String orderId;
  Item(
      {required this.id,
      required this.uuid,
      required this.type,
      required this.title,
      required this.dateBought,
      required this.releaseDate,
      required this.currency,
      required this.price,
      required this.shipping,
      required this.image,
      required this.link,
      required this.delivered,
      required this.import,
      required this.paid,
      required this.canceled,
      required this.orderId});
  factory Item.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Item(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      uuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uuid'])!,
      type: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      dateBought: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_bought'])!,
      releaseDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date'])!,
      currency: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}currency'])!,
      price: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
      shipping: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}shipping'])!,
      image: const BlobType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image'])!,
      link: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}link'])!,
      delivered: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}delivered'])!,
      import: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}import'])!,
      paid: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}paid'])!,
      canceled: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}canceled'])!,
      orderId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['type'] = Variable<int>(type);
    map['title'] = Variable<String>(title);
    map['date_bought'] = Variable<DateTime>(dateBought);
    map['release_date'] = Variable<DateTime>(releaseDate);
    map['currency'] = Variable<String>(currency);
    map['price'] = Variable<double>(price);
    map['shipping'] = Variable<double>(shipping);
    map['image'] = Variable<Uint8List>(image);
    map['link'] = Variable<String>(link);
    map['delivered'] = Variable<bool>(delivered);
    map['import'] = Variable<bool>(import);
    map['paid'] = Variable<bool>(paid);
    map['canceled'] = Variable<bool>(canceled);
    map['order_id'] = Variable<String>(orderId);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      type: Value(type),
      title: Value(title),
      dateBought: Value(dateBought),
      releaseDate: Value(releaseDate),
      currency: Value(currency),
      price: Value(price),
      shipping: Value(shipping),
      image: Value(image),
      link: Value(link),
      delivered: Value(delivered),
      import: Value(import),
      paid: Value(paid),
      canceled: Value(canceled),
      orderId: Value(orderId),
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      type: serializer.fromJson<int>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      dateBought: serializer.fromJson<DateTime>(json['dateBought']),
      releaseDate: serializer.fromJson<DateTime>(json['releaseDate']),
      currency: serializer.fromJson<String>(json['currency']),
      price: serializer.fromJson<double>(json['price']),
      shipping: serializer.fromJson<double>(json['shipping']),
      image: serializer.fromJson<Uint8List>(json['image']),
      link: serializer.fromJson<String>(json['link']),
      delivered: serializer.fromJson<bool>(json['delivered']),
      import: serializer.fromJson<bool>(json['import']),
      paid: serializer.fromJson<bool>(json['paid']),
      canceled: serializer.fromJson<bool>(json['canceled']),
      orderId: serializer.fromJson<String>(json['orderId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'type': serializer.toJson<int>(type),
      'title': serializer.toJson<String>(title),
      'dateBought': serializer.toJson<DateTime>(dateBought),
      'releaseDate': serializer.toJson<DateTime>(releaseDate),
      'currency': serializer.toJson<String>(currency),
      'price': serializer.toJson<double>(price),
      'shipping': serializer.toJson<double>(shipping),
      'image': serializer.toJson<Uint8List>(image),
      'link': serializer.toJson<String>(link),
      'delivered': serializer.toJson<bool>(delivered),
      'import': serializer.toJson<bool>(import),
      'paid': serializer.toJson<bool>(paid),
      'canceled': serializer.toJson<bool>(canceled),
      'orderId': serializer.toJson<String>(orderId),
    };
  }

  Item copyWith(
          {int? id,
          String? uuid,
          int? type,
          String? title,
          DateTime? dateBought,
          DateTime? releaseDate,
          String? currency,
          double? price,
          double? shipping,
          Uint8List? image,
          String? link,
          bool? delivered,
          bool? import,
          bool? paid,
          bool? canceled,
          String? orderId}) =>
      Item(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        type: type ?? this.type,
        title: title ?? this.title,
        dateBought: dateBought ?? this.dateBought,
        releaseDate: releaseDate ?? this.releaseDate,
        currency: currency ?? this.currency,
        price: price ?? this.price,
        shipping: shipping ?? this.shipping,
        image: image ?? this.image,
        link: link ?? this.link,
        delivered: delivered ?? this.delivered,
        import: import ?? this.import,
        paid: paid ?? this.paid,
        canceled: canceled ?? this.canceled,
        orderId: orderId ?? this.orderId,
      );
  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('dateBought: $dateBought, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('currency: $currency, ')
          ..write('price: $price, ')
          ..write('shipping: $shipping, ')
          ..write('image: $image, ')
          ..write('link: $link, ')
          ..write('delivered: $delivered, ')
          ..write('import: $import, ')
          ..write('paid: $paid, ')
          ..write('canceled: $canceled, ')
          ..write('orderId: $orderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuid,
      type,
      title,
      dateBought,
      releaseDate,
      currency,
      price,
      shipping,
      image,
      link,
      delivered,
      import,
      paid,
      canceled,
      orderId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.type == this.type &&
          other.title == this.title &&
          other.dateBought == this.dateBought &&
          other.releaseDate == this.releaseDate &&
          other.currency == this.currency &&
          other.price == this.price &&
          other.shipping == this.shipping &&
          other.image == this.image &&
          other.link == this.link &&
          other.delivered == this.delivered &&
          other.import == this.import &&
          other.paid == this.paid &&
          other.canceled == this.canceled &&
          other.orderId == this.orderId);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<int> type;
  final Value<String> title;
  final Value<DateTime> dateBought;
  final Value<DateTime> releaseDate;
  final Value<String> currency;
  final Value<double> price;
  final Value<double> shipping;
  final Value<Uint8List> image;
  final Value<String> link;
  final Value<bool> delivered;
  final Value<bool> import;
  final Value<bool> paid;
  final Value<bool> canceled;
  final Value<String> orderId;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.dateBought = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.currency = const Value.absent(),
    this.price = const Value.absent(),
    this.shipping = const Value.absent(),
    this.image = const Value.absent(),
    this.link = const Value.absent(),
    this.delivered = const Value.absent(),
    this.import = const Value.absent(),
    this.paid = const Value.absent(),
    this.canceled = const Value.absent(),
    this.orderId = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required int type,
    required String title,
    required DateTime dateBought,
    required DateTime releaseDate,
    required String currency,
    required double price,
    required double shipping,
    required Uint8List image,
    required String link,
    required bool delivered,
    required bool import,
    required bool paid,
    required bool canceled,
    required String orderId,
  })  : uuid = Value(uuid),
        type = Value(type),
        title = Value(title),
        dateBought = Value(dateBought),
        releaseDate = Value(releaseDate),
        currency = Value(currency),
        price = Value(price),
        shipping = Value(shipping),
        image = Value(image),
        link = Value(link),
        delivered = Value(delivered),
        import = Value(import),
        paid = Value(paid),
        canceled = Value(canceled),
        orderId = Value(orderId);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<int>? type,
    Expression<String>? title,
    Expression<DateTime>? dateBought,
    Expression<DateTime>? releaseDate,
    Expression<String>? currency,
    Expression<double>? price,
    Expression<double>? shipping,
    Expression<Uint8List>? image,
    Expression<String>? link,
    Expression<bool>? delivered,
    Expression<bool>? import,
    Expression<bool>? paid,
    Expression<bool>? canceled,
    Expression<String>? orderId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (dateBought != null) 'date_bought': dateBought,
      if (releaseDate != null) 'release_date': releaseDate,
      if (currency != null) 'currency': currency,
      if (price != null) 'price': price,
      if (shipping != null) 'shipping': shipping,
      if (image != null) 'image': image,
      if (link != null) 'link': link,
      if (delivered != null) 'delivered': delivered,
      if (import != null) 'import': import,
      if (paid != null) 'paid': paid,
      if (canceled != null) 'canceled': canceled,
      if (orderId != null) 'order_id': orderId,
    });
  }

  ItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<int>? type,
      Value<String>? title,
      Value<DateTime>? dateBought,
      Value<DateTime>? releaseDate,
      Value<String>? currency,
      Value<double>? price,
      Value<double>? shipping,
      Value<Uint8List>? image,
      Value<String>? link,
      Value<bool>? delivered,
      Value<bool>? import,
      Value<bool>? paid,
      Value<bool>? canceled,
      Value<String>? orderId}) {
    return ItemsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      type: type ?? this.type,
      title: title ?? this.title,
      dateBought: dateBought ?? this.dateBought,
      releaseDate: releaseDate ?? this.releaseDate,
      currency: currency ?? this.currency,
      price: price ?? this.price,
      shipping: shipping ?? this.shipping,
      image: image ?? this.image,
      link: link ?? this.link,
      delivered: delivered ?? this.delivered,
      import: import ?? this.import,
      paid: paid ?? this.paid,
      canceled: canceled ?? this.canceled,
      orderId: orderId ?? this.orderId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dateBought.present) {
      map['date_bought'] = Variable<DateTime>(dateBought.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime>(releaseDate.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (shipping.present) {
      map['shipping'] = Variable<double>(shipping.value);
    }
    if (image.present) {
      map['image'] = Variable<Uint8List>(image.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (delivered.present) {
      map['delivered'] = Variable<bool>(delivered.value);
    }
    if (import.present) {
      map['import'] = Variable<bool>(import.value);
    }
    if (paid.present) {
      map['paid'] = Variable<bool>(paid.value);
    }
    if (canceled.present) {
      map['canceled'] = Variable<bool>(canceled.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('dateBought: $dateBought, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('currency: $currency, ')
          ..write('price: $price, ')
          ..write('shipping: $shipping, ')
          ..write('image: $image, ')
          ..write('link: $link, ')
          ..write('delivered: $delivered, ')
          ..write('import: $import, ')
          ..write('paid: $paid, ')
          ..write('canceled: $canceled, ')
          ..write('orderId: $orderId')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String?> uuid = GeneratedColumn<String?>(
      'uuid', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int?> type = GeneratedColumn<int?>(
      'type', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dateBoughtMeta = const VerificationMeta('dateBought');
  @override
  late final GeneratedColumn<DateTime?> dateBought = GeneratedColumn<DateTime?>(
      'date_bought', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<DateTime?> releaseDate =
      GeneratedColumn<DateTime?>('release_date', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _currencyMeta = const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String?> currency = GeneratedColumn<String?>(
      'currency', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double?> price = GeneratedColumn<double?>(
      'price', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _shippingMeta = const VerificationMeta('shipping');
  @override
  late final GeneratedColumn<double?> shipping = GeneratedColumn<double?>(
      'shipping', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<Uint8List?> image = GeneratedColumn<Uint8List?>(
      'image', aliasedName, false,
      type: const BlobType(), requiredDuringInsert: true);
  final VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String?> link = GeneratedColumn<String?>(
      'link', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _deliveredMeta = const VerificationMeta('delivered');
  @override
  late final GeneratedColumn<bool?> delivered = GeneratedColumn<bool?>(
      'delivered', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (delivered IN (0, 1))');
  final VerificationMeta _importMeta = const VerificationMeta('import');
  @override
  late final GeneratedColumn<bool?> import = GeneratedColumn<bool?>(
      'import', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (import IN (0, 1))');
  final VerificationMeta _paidMeta = const VerificationMeta('paid');
  @override
  late final GeneratedColumn<bool?> paid = GeneratedColumn<bool?>(
      'paid', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (paid IN (0, 1))');
  final VerificationMeta _canceledMeta = const VerificationMeta('canceled');
  @override
  late final GeneratedColumn<bool?> canceled = GeneratedColumn<bool?>(
      'canceled', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (canceled IN (0, 1))');
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String?> orderId = GeneratedColumn<String?>(
      'order_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        type,
        title,
        dateBought,
        releaseDate,
        currency,
        price,
        shipping,
        image,
        link,
        delivered,
        import,
        paid,
        canceled,
        orderId
      ];
  @override
  String get aliasedName => _alias ?? 'items';
  @override
  String get actualTableName => 'items';
  @override
  VerificationContext validateIntegrity(Insertable<Item> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('date_bought')) {
      context.handle(
          _dateBoughtMeta,
          dateBought.isAcceptableOrUnknown(
              data['date_bought']!, _dateBoughtMeta));
    } else if (isInserting) {
      context.missing(_dateBoughtMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('shipping')) {
      context.handle(_shippingMeta,
          shipping.isAcceptableOrUnknown(data['shipping']!, _shippingMeta));
    } else if (isInserting) {
      context.missing(_shippingMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('delivered')) {
      context.handle(_deliveredMeta,
          delivered.isAcceptableOrUnknown(data['delivered']!, _deliveredMeta));
    } else if (isInserting) {
      context.missing(_deliveredMeta);
    }
    if (data.containsKey('import')) {
      context.handle(_importMeta,
          import.isAcceptableOrUnknown(data['import']!, _importMeta));
    } else if (isInserting) {
      context.missing(_importMeta);
    }
    if (data.containsKey('paid')) {
      context.handle(
          _paidMeta, paid.isAcceptableOrUnknown(data['paid']!, _paidMeta));
    } else if (isInserting) {
      context.missing(_paidMeta);
    }
    if (data.containsKey('canceled')) {
      context.handle(_canceledMeta,
          canceled.isAcceptableOrUnknown(data['canceled']!, _canceledMeta));
    } else if (isInserting) {
      context.missing(_canceledMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Item.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

abstract class _$YoyakuDatabase extends GeneratedDatabase {
  _$YoyakuDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ItemsTable items = $ItemsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [items];
}
