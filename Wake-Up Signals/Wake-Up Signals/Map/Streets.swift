//
//  Streets.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 2/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation
//
//George Street:
//Beggining : -33.861336, 151.208214
//P1: -33.862301, 151.207640
//P2: -33.863934, 151.207435
//P3: -33.865120, 151.207331
//P4: -33.867206, 151.207107
//P5: -33.869118, 151.206904
//P6: -33.871729, 151.207000
//P7: -33.874036, 151.206882
//P8: -33.875764, 151.206410
//P9:
//End: -33.877734, 151.205710
//
//Api Call:
//https://roads.googleapis.com/v1/nearestRoads?points=-33.861336,151.208214|-33.877734, 151.205710&interpolate=true&key=AIzaSyBOeGYL-Lo-yp1ekar69l1TMGGUQH9TuIs
//
//https://roads.googleapis.com/v1/snapToRoads?path=-33.861336,151.208214|-33.877734,151.205710|-33.862301,151.207640|-33.863934,151.207435|-33.865120,151.207331|-33.867206,151.207107|-33.869118,151.206904|-33.871729,151.207000|-33.874036,151.206882|-33.875764,15.206410&interpolate=true&key=AIzaSyBOeGYL-Lo-yp1ekar69l1TMGGUQH9TuIs
//
////George Street:
//{
//    "snappedPoints": [
//    {
//    "location": {
//    "latitude": -33.861345117099873,
//    "longitude": 151.20823700306875
//    },
//    "originalIndex": 0,
//    "placeId": "ChIJA8UCW0KuEmsRHFE2vQAwsSU"
//    },
//    {
//    "location": {
//    "latitude": -33.861438199999995,
//    "longitude": 151.2081835
//    },
//    "placeId": "ChIJA8UCW0KuEmsRHFE2vQAwsSU"
//    },
//    {
//    "location": {
//    "latitude": -33.861438199999995,
//    "longitude": 151.2081835
//    },
//    "placeId": "ChIJOZScRUKuEmsRdo91aU8IGuI"
//    },
//    {
//    "location": {
//    "latitude": -33.861780599999996,
//    "longitude": 151.20796869999998
//    },
//    "placeId": "ChIJOZScRUKuEmsRdo91aU8IGuI"
//    },
//    {
//    "location": {
//    "latitude": -33.861780599999996,
//    "longitude": 151.20796869999998
//    },
//    "placeId": "ChIJ6YaRSEKuEmsRpPbtbC810nw"
//    },
//    {
//    "location": {
//    "latitude": -33.861852499999991,
//    "longitude": 151.20792459999998
//    },
//    "placeId": "ChIJ6YaRSEKuEmsRpPbtbC810nw"
//    },
//    {
//    "location": {
//    "latitude": -33.861852499999991,
//    "longitude": 151.20792459999998
//    },
//    "placeId": "ChIJPZvVSUKuEmsR0EaC5Wd9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8621024,
//    "longitude": 151.2077773
//    },
//    "placeId": "ChIJPZvVSUKuEmsR0EaC5Wd9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8621024,
//    "longitude": 151.2077773
//    },
//    "placeId": "ChIJJXiaNkKuEmsRIEuC5Wd9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8622678,
//    "longitude": 151.20767519999998
//    },
//    "placeId": "ChIJJXiaNkKuEmsRIEuC5Wd9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8622678,
//    "longitude": 151.20767519999998
//    },
//    "placeId": "ChIJ4X9KLEKuEmsRwEO252d9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.862306178814244,
//    "longitude": 151.20765296207793
//    },
//    "originalIndex": 2,
//    "placeId": "ChIJ4X9KLEKuEmsRwEO252d9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8624195,
//    "longitude": 151.2075873
//    },
//    "placeId": "ChIJ4X9KLEKuEmsRwEO252d9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.862513899999996,
//    "longitude": 151.2075506
//    },
//    "placeId": "ChIJ4X9KLEKuEmsRwEO252d9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8626042,
//    "longitude": 151.2075283
//    },
//    "placeId": "ChIJ4X9KLEKuEmsRwEO252d9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.862698099999996,
//    "longitude": 151.2075108
//    },
//    "placeId": "ChIJ4X9KLEKuEmsRwEO252d9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.862803299999996,
//    "longitude": 151.2075024
//    },
//    "placeId": "ChIJ4X9KLEKuEmsRwEO252d9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8632251,
//    "longitude": 151.20749189999998
//    },
//    "placeId": "ChIJ4X9KLEKuEmsRwEO252d9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8632251,
//    "longitude": 151.20749189999998
//    },
//    "placeId": "ChIJ30xggEGuEmsRkjdcIOpKiUU"
//    },
//    {
//    "location": {
//    "latitude": -33.8632931,
//    "longitude": 151.20748880000002
//    },
//    "placeId": "ChIJ30xggEGuEmsRkjdcIOpKiUU"
//    },
//    {
//    "location": {
//    "latitude": -33.8632931,
//    "longitude": 151.20748880000002
//    },
//    "placeId": "ChIJU4esgUGuEmsRKhQEaULOyOI"
//    },
//    {
//    "location": {
//    "latitude": -33.8634933,
//    "longitude": 151.2074739
//    },
//    "placeId": "ChIJU4esgUGuEmsRKhQEaULOyOI"
//    },
//    {
//    "location": {
//    "latitude": -33.8634933,
//    "longitude": 151.2074739
//    },
//    "placeId": "ChIJaa-ZgUGuEmsRdOvecoBLmnA"
//    },
//    {
//    "location": {
//    "latitude": -33.863568799999996,
//    "longitude": 151.20746359999998
//    },
//    "placeId": "ChIJaa-ZgUGuEmsRdOvecoBLmnA"
//    },
//    {
//    "location": {
//    "latitude": -33.8636209,
//    "longitude": 151.2074606
//    },
//    "placeId": "ChIJaa-ZgUGuEmsRdOvecoBLmnA"
//    },
//    {
//    "location": {
//    "latitude": -33.8636209,
//    "longitude": 151.2074606
//    },
//    "placeId": "ChIJ9VISnUGuEmsRcMyO5md9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.863933695693355,
//    "longitude": 151.2074304250352
//    },
//    "originalIndex": 3,
//    "placeId": "ChIJ9VISnUGuEmsRcMyO5md9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8641703,
//    "longitude": 151.2074076
//    },
//    "placeId": "ChIJ9VISnUGuEmsRcMyO5md9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8641703,
//    "longitude": 151.2074076
//    },
//    "placeId": "ChIJp9E4nkGuEmsRkJmC5Wd9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.864317799999995,
//    "longitude": 151.207395
//    },
//    "placeId": "ChIJp9E4nkGuEmsRkJmC5Wd9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.864317799999995,
//    "longitude": 151.207395
//    },
//    "placeId": "ChIJd7_2n0GuEmsRcKSC5Wd9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.864620400000007,
//    "longitude": 151.20737309999998
//    },
//    "placeId": "ChIJd7_2n0GuEmsRcKSC5Wd9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.864620400000007,
//    "longitude": 151.20737309999998
//    },
//    "placeId": "ChIJS3lRp0GuEmsRCNhodocN5L4"
//    },
//    {
//    "location": {
//    "latitude": -33.865120385813789,
//    "longitude": 151.20733927002391
//    },
//    "originalIndex": 4,
//    "placeId": "ChIJS3lRp0GuEmsRCNhodocN5L4"
//    },
//    {
//    "location": {
//    "latitude": -33.8651362,
//    "longitude": 151.20733819999998
//    },
//    "placeId": "ChIJS3lRp0GuEmsRCNhodocN5L4"
//    },
//    {
//    "location": {
//    "latitude": -33.8651362,
//    "longitude": 151.20733819999998
//    },
//    "placeId": "ChIJ14VeB0GuEmsR0MaC5Wd9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8655282,
//    "longitude": 151.2073106
//    },
//    "placeId": "ChIJ14VeB0GuEmsR0MaC5Wd9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8655282,
//    "longitude": 151.2073106
//    },
//    "placeId": "ChIJUwZzAEGuEmsRVE_CYoYKFqA"
//    },
//    {
//    "location": {
//    "latitude": -33.8657588,
//    "longitude": 151.2072857
//    },
//    "placeId": "ChIJUwZzAEGuEmsRVE_CYoYKFqA"
//    },
//    {
//    "location": {
//    "latitude": -33.8657588,
//    "longitude": 151.2072857
//    },
//    "placeId": "ChIJp_Ka_0CuEmsRLBj6JqAXpDM"
//    },
//    {
//    "location": {
//    "latitude": -33.8659232,
//    "longitude": 151.2072676
//    },
//    "placeId": "ChIJp_Ka_0CuEmsRLBj6JqAXpDM"
//    },
//    {
//    "location": {
//    "latitude": -33.8659232,
//    "longitude": 151.2072676
//    },
//    "placeId": "ChIJJb9u_0CuEmsRkolIvgnJYbA"
//    },
//    {
//    "location": {
//    "latitude": -33.8659375,
//    "longitude": 151.2072661
//    },
//    "placeId": "ChIJJb9u_0CuEmsRkolIvgnJYbA"
//    },
//    {
//    "location": {
//    "latitude": -33.8659375,
//    "longitude": 151.2072661
//    },
//    "placeId": "ChIJ2cGM-ECuEmsRdpNiHqr5mEg"
//    },
//    {
//    "location": {
//    "latitude": -33.866329900000004,
//    "longitude": 151.2072565
//    },
//    "placeId": "ChIJ2cGM-ECuEmsRdpNiHqr5mEg"
//    },
//    {
//    "location": {
//    "latitude": -33.866329900000004,
//    "longitude": 151.2072565
//    },
//    "placeId": "ChIJEwG890CuEmsRRn_ozcdD9po"
//    },
//    {
//    "location": {
//    "latitude": -33.8665078,
//    "longitude": 151.2072081
//    },
//    "placeId": "ChIJEwG890CuEmsRRn_ozcdD9po"
//    },
//    {
//    "location": {
//    "latitude": -33.8665078,
//    "longitude": 151.2072081
//    },
//    "placeId": "ChIJJ9yq9UCuEmsRwN5y5md9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8671067,
//    "longitude": 151.2071464
//    },
//    "placeId": "ChIJJ9yq9UCuEmsRwN5y5md9ARM"
//    },
//    {
//    "location": {
//    "latitude": -33.8671067,
//    "longitude": 151.2071464
//    },
//    "placeId": "ChIJ9RzYi0CuEmsR3PP875uF4vE"
//    },
//    {
//    "location": {
//    "latitude": -33.867208454311609,
//    "longitude": 151.20713178574408
//    },
//    "originalIndex": 5,
//    "placeId": "ChIJ9RzYi0CuEmsR3PP875uF4vE"
//    },
//    {
//    "location": {
//    "latitude": -33.8674423,
//    "longitude": 151.20709820000002
//    },
//    "placeId": "ChIJ9RzYi0CuEmsR3PP875uF4vE"
//    },
//    {
//    "location": {
//    "latitude": -33.8674423,
//    "longitude": 151.20709820000002
//    },
//    "placeId": "ChIJ39OQiECuEmsR9CTcwRhCb84"
//    },
//    {
//    "location": {
//    "latitude": -33.867650399999995,
//    "longitude": 151.207069
//    },
//    "placeId": "ChIJ39OQiECuEmsR9CTcwRhCb84"
//    },
//    {
//    "location": {
//    "latitude": -33.867650399999995,
//    "longitude": 151.207069
//    },
//    "placeId": "ChIJAwk2g0CuEmsRjJ3hBLFXDgU"
//    },
//    {
//    "location": {
//    "latitude": -33.868196999999988,
//    "longitude": 151.2069899
//    },
//    "placeId": "ChIJAwk2g0CuEmsRjJ3hBLFXDgU"
//    },
//    {
//    "location": {
//    "latitude": -33.868196999999988,
//    "longitude": 151.2069899
//    },
//    "placeId": "ChIJD_9efD-uEmsRbK8JOL0FUKY"
//    },
//    {
//    "location": {
//    "latitude": -33.8686985,
//    "longitude": 151.20692359999998
//    },
//    "placeId": "ChIJD_9efD-uEmsRbK8JOL0FUKY"
//    },
//    {
//    "location": {
//    "latitude": -33.8686985,
//    "longitude": 151.20692359999998
//    },
//    "placeId": "ChIJgQo1cT-uEmsRNCAoz9uBqSU"
//    },
//    {
//    "location": {
//    "latitude": -33.869117430404991,
//    "longitude": 151.20693482757642
//    },
//    "originalIndex": 6,
//    "placeId": "ChIJgQo1cT-uEmsRNCAoz9uBqSU"
//    },
//    {
//    "location": {
//    "latitude": -33.869414899999995,
//    "longitude": 151.2069428
//    },
//    "placeId": "ChIJgQo1cT-uEmsRNCAoz9uBqSU"
//    },
//    {
//    "location": {
//    "latitude": -33.869414899999995,
//    "longitude": 151.2069428
//    },
//    "placeId": "ChIJO2mhDD-uEmsRzuT5BO6Ix2I"
//    },
//    {
//    "location": {
//    "latitude": -33.8696847,
//    "longitude": 151.206944
//    },
//    "placeId": "ChIJO2mhDD-uEmsRzuT5BO6Ix2I"
//    },
//    {
//    "location": {
//    "latitude": -33.8696847,
//    "longitude": 151.206944
//    },
//    "placeId": "ChIJHQzeBT-uEmsRRtQGjnqbglA"
//    },
//    {
//    "location": {
//    "latitude": -33.8707081,
//    "longitude": 151.2069722
//    },
//    "placeId": "ChIJHQzeBT-uEmsRRtQGjnqbglA"
//    },
//    {
//    "location": {
//    "latitude": -33.8707081,
//    "longitude": 151.2069722
//    },
//    "placeId": "ChIJ8cn-_T6uEmsRPIxX1pxyV2k"
//    },
//    {
//    "location": {
//    "latitude": -33.870767199999996,
//    "longitude": 151.2069746
//    },
//    "placeId": "ChIJ8cn-_T6uEmsRPIxX1pxyV2k"
//    },
//    {
//    "location": {
//    "latitude": -33.870767199999996,
//    "longitude": 151.2069746
//    },
//    "placeId": "ChIJ0XiH-T6uEmsRCuqq6-fyfHs"
//    },
//    {
//    "location": {
//    "latitude": -33.871728665673317,
//    "longitude": 151.20701235128419
//    },
//    "originalIndex": 7,
//    "placeId": "ChIJ0XiH-T6uEmsRCuqq6-fyfHs"
//    },
//    {
//    "location": {
//    "latitude": -33.871735,
//    "longitude": 151.20701259999998
//    },
//    "placeId": "ChIJ0XiH-T6uEmsRCuqq6-fyfHs"
//    },
//    {
//    "location": {
//    "latitude": -33.871735,
//    "longitude": 151.20701259999998
//    },
//    "placeId": "ChIJd4mZ9D6uEmsRsEsoRjSLJLk"
//    },
//    {
//    "location": {
//    "latitude": -33.8721543,
//    "longitude": 151.207025
//    },
//    "placeId": "ChIJd4mZ9D6uEmsRsEsoRjSLJLk"
//    },
//    {
//    "location": {
//    "latitude": -33.8721543,
//    "longitude": 151.207025
//    },
//    "placeId": "ChIJ_530iz6uEmsRRPHzUcQcJ5M"
//    },
//    {
//    "location": {
//    "latitude": -33.872406,
//    "longitude": 151.2070335
//    },
//    "placeId": "ChIJ_530iz6uEmsRRPHzUcQcJ5M"
//    },
//    {
//    "location": {
//    "latitude": -33.872406,
//    "longitude": 151.2070335
//    },
//    "placeId": "ChIJ1b8xiT6uEmsRpHGfIS5xRvc"
//    },
//    {
//    "location": {
//    "latitude": -33.872537699999995,
//    "longitude": 151.2070432
//    },
//    "placeId": "ChIJ1b8xiT6uEmsRpHGfIS5xRvc"
//    },
//    {
//    "location": {
//    "latitude": -33.872537699999995,
//    "longitude": 151.2070432
//    },
//    "placeId": "ChIJSfrOiD6uEmsRTiRv2P-A7ew"
//    },
//    {
//    "location": {
//    "latitude": -33.8726033,
//    "longitude": 151.2070451
//    },
//    "placeId": "ChIJSfrOiD6uEmsRTiRv2P-A7ew"
//    },
//    {
//    "location": {
//    "latitude": -33.8726033,
//    "longitude": 151.2070451
//    },
//    "placeId": "ChIJKy2wiD6uEmsR6McAQuO15ZA"
//    },
//    {
//    "location": {
//    "latitude": -33.8726669,
//    "longitude": 151.2070464
//    },
//    "placeId": "ChIJKy2wiD6uEmsR6McAQuO15ZA"
//    },
//    {
//    "location": {
//    "latitude": -33.8726669,
//    "longitude": 151.2070464
//    },
//    "placeId": "ChIJYfV8hj6uEmsRDDoVtR2iaao"
//    },
//    {
//    "location": {
//    "latitude": -33.8729733,
//    "longitude": 151.2070365
//    },
//    "placeId": "ChIJYfV8hj6uEmsRDDoVtR2iaao"
//    },
//    {
//    "location": {
//    "latitude": -33.8729733,
//    "longitude": 151.2070365
//    },
//    "placeId": "ChIJ88f_KTyuEmsRE1NofBZx8ig"
//    },
//    {
//    "location": {
//    "latitude": -33.8735922,
//    "longitude": 151.20696909999998
//    },
//    "placeId": "ChIJ88f_KTyuEmsRE1NofBZx8ig"
//    },
//    {
//    "location": {
//    "latitude": -33.8735922,
//    "longitude": 151.20696909999998
//    },
//    "placeId": "ChIJ9XzAMTyuEmsRMQOzSzfDYGs"
//    },
//    {
//    "location": {
//    "latitude": -33.874038209436193,
//    "longitude": 151.20690393784864
//    },
//    "originalIndex": 8,
//    "placeId": "ChIJ9XzAMTyuEmsRMQOzSzfDYGs"
//    }
//    ],
//    "warningMessage": "Input path is too sparse. You should provide a path where consecutive points are closer to each other. Refer to the 'path' parameter in Google Roads API documentation."
//}
