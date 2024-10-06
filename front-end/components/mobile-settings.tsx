'use client'

import React, { useState, useEffect } from 'react'
import Image from 'next/image'
import { User, Bell, Moon, Lock, HelpCircle, LogOut } from 'lucide-react'
import { Switch } from '@/components/ui/switch'
import EG from '../public/EG.svg'

interface SettingsOption {
  icon: React.ReactNode
  label: string
  action?: () => void
  toggle?: boolean
}

interface Notification {
  id: number
  message: string
}

const notificationMessages = [
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

export function MobileSettingsComponent() {
  const settingsOptions: SettingsOption[] = [
    { icon: <Bell className="h-5 w-5" />, label: 'Notifications', toggle: true },
    { icon: <Moon className="h-5 w-5" />, label: 'Dark Mode', toggle: true },
    { icon: <Lock className="h-5 w-5" />, label: 'Privacy', action: () => console.log('Privacy settings') },
    { icon: <HelpCircle className="h-5 w-5" />, label: 'Help & Support', action: () => console.log('Help & Support') },
    { icon: <LogOut className="h-5 w-5" />, label: 'Log Out', action: () => console.log('Logging out') },
  ]

  const [notifications, setNotifications] = useState<Notification[]>([])
  const [isVisible, setIsVisible] = useState<boolean>(true)

  useEffect(() => {
    const handleVisibilityChange = () => {
      setIsVisible(!document.hidden)
    }

    document.addEventListener("visibilitychange", handleVisibilityChange)

    // Initialize isVisible state based on current document visibility
    setIsVisible(!document.hidden)

    return () => {
      document.removeEventListener("visibilitychange", handleVisibilityChange)
    }
  }, [])

  useEffect(() => {
    if (!isVisible) return

    const interval = setInterval(() => {
      if (Math.random() > 0.5) { // Simulate a 50% chance that the plant needs water
        const randomMessage = notificationMessages[Math.floor(Math.random() * notificationMessages.length)].message
        const newNotification: Notification = {
          id: Date.now(),
          message: randomMessage
        }
        setNotifications(prevNotifications => [newNotification, ...prevNotifications].slice(0, 3))
      }
    }, 6000)

    return () => clearInterval(interval)
  }, [isVisible])

  const removeNotification = (id: number) => {
    setNotifications(prevNotifications => prevNotifications.filter(notification => notification.id !== id))
  }

  console.log(notifications);
  console.log(isVisible);
  console.log(notificationMessages);
  console.log(removeNotification);

  return (
    <div className="bg-gray-100 min-h-screen p-4">
      <h1 className="text-2xl font-bold mb-6">Settings</h1>
      
      <div className="bg-white rounded-lg shadow-md p-4 mb-6">
        <div className="flex items-center space-x-4">
          <div className="relative w-16 h-16">
                { EG ? (
                  <Image
                    src={EG}
                    alt="Profile picture"
                    fill
                    className="rounded-full"
                  />
                ) : (
                  <div className="flex items-center justify-center w-full h-full bg-gray-300 rounded-full">
                    <User className="h-8 w-8 text-white" />
                  </div>
                )}
          </div>
          <div>
            <h2 className="text-xl font-semibold">Enkhbold Ganbold</h2>
            <p className="text-gray-600">enkhbold470@gmail.com</p>
          </div>
        </div>
        <button className="mt-4 text-blue-500 font-medium" onClick={() => console.log('Edit profile')}>
          Edit Profile
        </button>
      </div>

      <div className="bg-white rounded-lg shadow-md overflow-hidden">
        {settingsOptions.map((option, index) => (
          <div 
            key={option.label} 
            className={`flex items-center justify-between p-4 ${
              index !== settingsOptions.length - 1 ? 'border-b border-gray-200' : ''
            }`}
          >
            <div className="flex items-center space-x-3">
              {option.icon}
              <span>{option.label}</span>
            </div>
            {option.toggle ? (
              <Switch />
            ) : (
              <button onClick={option.action} className="text-blue-500">
                &gt;
              </button>
            )}
          </div>
        ))}
      </div>
    </div>
  )
}