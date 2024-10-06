    "use client"
    
    import React, { useState, useEffect } from 'react'
    import { AlertCircle, X } from 'lucide-react'
    
    interface Notification {
      id: number
      message: string
    }
    
    const notifications = [
      "Your plant needs water!",
      "I am thirsty!",
      "You better water me!",
      "I need some sunlight!",
      "I am dying!"
    ]
    
    export default function PlantNotification() {
      const [activeNotifications, setActiveNotifications] = useState<Notification[]>([])
    
      useEffect(() => {
        const interval = setInterval(() => {
          if (Math.random() > 0.5) {
            const newNotification: Notification = {
              id: Date.now(),
              message: notifications[Math.floor(Math.random() * notifications.length)]
            }
            setActiveNotifications(prev => [newNotification, ...prev].slice(0, 3))
          }
        }, 8000)
    
        return () => clearInterval(interval)
      }, [])
    
      const removeNotification = (id: number) => {
        setActiveNotifications(prev => prev.filter(n => n.id !== id))
      }
    
      return (
        <div className="fixed top-0 right-0 m-4 z-50 w-80">
          {activeNotifications.map((notification, index) => (
            <div
              key={notification.id}
              className="bg-white rounded-lg shadow-lg p-4 mb-2 flex items-center justify-between"
              style={{
                opacity: 1 - index * 0.2,
                transform: `translateY(${index * 10}px)`,
              }}
            >
              <div className="flex items-center">
                <AlertCircle className="h-6 w-6 text-red-500" />
                <p className="ml-2 text-sm font-medium text-gray-900">{notification.message}</p>
              </div>
              <button onClick={() => removeNotification(notification.id)}>
                <X className="h-4 w-4" />
              </button>
            </div>
          ))}
        </div>
      )
    }