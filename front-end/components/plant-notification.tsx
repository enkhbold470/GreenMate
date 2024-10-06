    // Start of Selection
    "use client"
    
    import React, { useState, useEffect } from 'react'
    import { AlertCircle, X } from 'lucide-react'
    
    interface Notification {
      id: number
      message: string
    }
    const notification = [
        {
            id: 1,
            message: "Your plant needs water!"
        },
        {
            id: 2,
            message: "I am thirsty!"
        },
        {
            id: 3,
            message: "You better water me!"
        },
        {
            id: 4,
            message: "I need some sunlight!"
        },
        {
            id: 5,
            message: "I am dying!"
        },
    ]
    
    export default function PlantNotification() {
      const [notifications, setNotifications] = useState<Notification[]>([])
      const [isVisible, setIsVisible] = useState<boolean>(!document.hidden)
    
      useEffect(() => {
        const handleVisibilityChange = () => {
          setIsVisible(!document.hidden)
        }
    
        document.addEventListener("visibilitychange", handleVisibilityChange)
    
        return () => {
          document.removeEventListener("visibilitychange", handleVisibilityChange)
        }
      }, [])
    
      useEffect(() => {
        if (!isVisible) return
    
        const interval = setInterval(() => {
          if (Math.random() > 0.5) { // Simulate a 50% chance that the plant needs water
            const newNotification: Notification = {
              id: Date.now(),
              message: notification[Math.floor(Math.random() * notification.length)].message
            }
            setNotifications(prevNotifications => [newNotification, ...prevNotifications].slice(0, 3))
          }
        }, 6000)
    
        return () => clearInterval(interval)
      }, [isVisible])
    
      const removeNotification = (id: number) => {
        setNotifications(prevNotifications => prevNotifications.filter(notification => notification.id !== id))
      }
    
      return (
        <div className="fixed top-0 right-0 m-4 z-50 w-80">
          {notifications.map((notification, index) => (
            <div
              key={notification.id}
              className={`bg-white rounded-lg shadow-lg p-4 mb-2 flex items-center justify-between
                          transform transition-all duration-300 ease-in-out
                          ${index === 0 ? 'animate-slide-in' : ''}`}
              style={{
                opacity: 1 - index * 0.2,
                transform: `translateY(${index * 10}px)`,
              }}
            >
              <div className="flex items-center">
                <div className="relative">
                  <AlertCircle className="h-6 w-6 text-red-500" />
                  <span className="absolute top-0 right-0 h-2 w-2 rounded-full bg-red-500 animate-ping"></span>
                </div>
                <p className="ml-2 text-sm font-medium text-gray-900">{notification.message}</p>
              </div>
              <button
                onClick={() => removeNotification(notification.id)}
                className="ml-4 text-gray-400 hover:text-gray-600 focus:outline-none"
              >
                <X className="h-4 w-4" />
              </button>
            </div>
          ))}
        </div>
      )
    }