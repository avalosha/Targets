//
//  DateExtension.swift
//  Colonos
//
//  Created by Sferea-Lider on 07/02/22.
//

import Foundation


extension Date {
    /// Obtiene el número del día, mes o año de la fecha correspondiente.
    /// - Parameters:
    ///     - component: Calendar.Component del tipo de dato a obtener.
    ///     - calendar: Calendar a utilizar.
    /// - Returns: Devuelve un entero.
    public func getNumber(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    /// Obtiene el número del día, mes o año como string de la fecha correspondiente.
    /// - Parameters:
    ///     - component: Calendar.Component del tipo de dato a obtener.
    ///     - calendar: Calendar a utilizar.
    /// - Returns: Devuelve un string.
    public func getString(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> String {
        let day = String(format: "%02d", getNumber(component))
        return day
    }
    
    /// Convertir la fecha y hora en horario local.
    /// - Returns: Date con la hora local.
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

        return localDate
    }
    
    /// Obtiene el ultimo día del año actual.
    func getLastDayOfTheYear() -> Date? {
        let year = getNumber(.year)
        if let firstOfNextYear = Calendar.current.date(from: DateComponents(year: year + 1, month: 1, day: 1)) {
            let lastOfYear = Calendar.current.date(byAdding: .day, value: -1, to: firstOfNextYear)
            return lastOfYear
        }
        return nil
    }
    
    func dayNumberOfWeek() -> Int? {
        guard let day = weekNumberOfDay else{
            return nil
        }
        return  (day-1 == 0) ?   7 : day - 1
    }
    
    public func convertToString(format: String, timeZone:String="") -> String {
        let dateFormatter = DateFormatter()
        let lc = "es_Mx"
        dateFormatter.locale = Locale(identifier: lc)
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        return dateFormatter.string(from: self).capitalized
    }
    
    func nearestHour() -> Date {
        var components = Calendar.current.dateComponents([.minute], from: self)
        let minute = components.minute ?? 0
        components.minute = minute >= 30 ?  60-minute : 30 - minute
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func nearestQuarterHour() -> Date {
        var components = Calendar.current.dateComponents([.minute], from: self)
        let minute = components.minute ?? 0
        components.minute = minute > 45 ? 60-minute : (minute > 30 && minute <= 45) ? 45-minute : (minute > 15 && minute < 30) ? 30-minute : 15-minute
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func startHour() -> Date {
        var components = Calendar.current.dateComponents([.minute,.second,.nanosecond], from: self)
        let minute = components.minute ?? 0
        let seconds = components.second ?? 0
        let mili = components.nanosecond ?? 0
        components.nanosecond = -mili
        components.minute = -minute
        components.second  = -seconds
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func getDayFromZero() -> Date? {
        let today = Date().convertToString(format: "yyyy-MM-dd")
        let fullDay = "\(today) \("00:00")"
        return fullDay.convertToDate(fromFormat: "yyyy-MM-dd HH:mm",timeZone: "America/Mexico_City")
    }
    
    public var numberOfDaysInMonth: Int? {
        get {
            let range = Calendar.current.range(of: .day, in: .month, for: self)
            return range?.count
        }
    }
    
    public var weekNumberOfDay: Int? {
        get {
            let components = Calendar.current.dateComponents([.weekday], from: self)
            return components.weekday
        }
    }
    
    public var firstDayOfMonth: Date? {
        get {
            let components = Calendar.current.dateComponents([.year,.month,.hour,.minute], from: self)
            return Calendar.current.date(from: components)
        }
    }
    
    public func add(_ n: Int,_ component:Calendar.Component) -> Date {
        Calendar.current.date(byAdding: component, value: n, to: self)!
    }
    
    public func add(_ component:DateComponents) -> Date {
        Calendar.current.date(byAdding: component, to: self)!
    }
}

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}
