import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

var profile = "https://avatars.githubusercontent.com/u/86506519?v=4";

List populars = [
  {
    "image": "https://images.unsplash.com/photo-1494526585095-c41746248156?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "name": "Casa Tipo 2",
    "price": "25.800",
    "location": "Coop, Maputo",
    "is_favorited": true,
    "category": "Casas",
  },
  {
    "image": "https://images.unsplash.com/photo-1598928506311-c55ded91a20c?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Casa no Triunfo",
    "price": "150.0000",
    "location": "Triunfo, Maputo",
    "is_favorited": false,
    "category": "Casas",
  },
  {
    "image": "https://images.unsplash.com/photo-1416331108676-a22ccb276e35?q=80&w=1734&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "name": "Casa Com Piscina",
    "price": "17.500",
    "location": "Mozal, Moçambique",
    "is_favorited": false,
    "category": "Casas",
  },
  {
    "image": "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "name": "Apartamento Na Coop",
    "price": "90.000",
    "location": "Coop, Maputo",
    "is_favorited": false,
    "category": "Apartamentos",
  },
];

List recommended = [
  {
    "image": "https://images.unsplash.com/photo-1604348825621-22800b6ed16d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGJlYWNoJTIwaG91c2V8ZW58MHx8MHx8fDA%3D",
    "name": "Casa Na Praia",
    "price": "18.000",
    "location": "Ponta de Ouro, Maputo",
    "is_favorited": true,
    "category": "Casas",
  },
  {
    "image": "https://images.unsplash.com/photo-1416331108676-a22ccb276e35?q=80&w=1734&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "name": "Casa Com Piscina ",
    "price": "17.500",
    "location": "Triunfo, Maputo",
    "is_favorited": false,
    "category": "Casas",
  },
  {
    "image": "https://images.unsplash.com/photo-1507149833265-60c372daea22?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDExfHx8ZW58MHx8fHx8",
    "name": "Apartamneto tipo 4",
    "price": "140.000",
    "location": "25 de Setembro, Maputo",
    "is_favorited": true,
    "category": "Apartamentos",
  },
];

List recents = [
  {
    "image": "https://images.unsplash.com/photo-1604348825621-22800b6ed16d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGJlYWNoJTIwaG91c2V8ZW58MHx8MHx8fDA%3D",
    "name": "Casa Na Praia",
    "price": "18.000",
    "location": "Ponta de Ouro, Maputo",
    "is_favorited": true,
    "category": "Casas",
  },
  {
    "image": "https://images.unsplash.com/photo-1416331108676-a22ccb276e35?q=80&w=1734&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "name": "Casa Com Piscina ",
    "price": "17.500",
    "location": "Triunfo, Maputo",
    "is_favorited": false,
    "category": "Casas",
  },
  {
    "image": "https://images.unsplash.com/photo-1494526585095-c41746248156?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "name": "Casa Tipo 2",
    "price": "25.800",
    "location": "Coop, Maputo",
    "is_favorited": true,
    "category": "Casas",
  },
];

List categories = [
  {
    "name" : "Tudo",
    "icon" :  FontAwesomeIcons.boxesStacked
  },
  {
    "name" : "Casas",
    "icon" :  FontAwesomeIcons.house
  },
  {
    "name" : "Apartamentos",
    "icon" :  FontAwesomeIcons.building
  },
  {
    "name" : "Loja",
    "icon" :  FontAwesomeIcons.shop
  },
  {
    "name" : "Fabricas",
    "icon" :  FontAwesomeIcons.warehouse
  },
];

var brokers = [
    {
    "image": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjV8fHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", 
    "name": "Alice Cristina", 
    "type": "Corretor", 
    "description": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4, 
  },
  {
    "image":"https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name" : "Amade Ali",
    "type": "Corretor", 
    "description": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 3, 
  },
  {
    "image" : "https://images.unsplash.com/photo-1617069470302-9b5592c80f66?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Z2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Naira Leandra", 
    "type": "Corretor", 
    "description": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4, 
  },
  {
    "image" : "https://images.unsplash.com/photo-1545167622-3a6ac756afa4?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTB8fHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Benicio Vilanculos", 
    "type": "Corretor", 
    "description": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 2, 
  },
];

List companies = [
  {
    "image": "https://images.unsplash.com/photo-1549517045-bc93de075e53?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "JC LTD",
    "location": "Maputo, Mozambique",
    "type": "Corretora",
    "is_favorited": false,
    "icon" : Icons.domain_rounded
  },
  {
    "image": "https://images.unsplash.com/photo-1618221469555-7f3ad97540d6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Palma",
    "location": "Maputo, Mozambique",
    "type": "Corretora",
    "is_favorited": true,
    "icon" : Icons.house_siding_rounded
  },
  {
    "image": "https://images.unsplash.com/photo-1625602812206-5ec545ca1231?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Kaizen",
    "location": "Maputo, Mozambique",
    "type": "Corretora",
    "is_favorited": true,
    "icon" : Icons.home_work_rounded
  },
  {
    "image": "https://images.unsplash.com/photo-1625602812206-5ec545ca1231?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Foxglove",
    "location": "Maputo, Mozambique",
    "type": "Corretora",
    "is_favorited": true,
    "icon" : Icons.location_city_rounded
  },
];
