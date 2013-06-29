//
//  BMKVersion.h
//  BMapKit
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


/*****������־��*****
 V0.1.0�� ���԰�
 ֧�ֵ�ͼ�������������
 ֧��POI����
 ֧��·������
 ֧�ֵ�����빦��
 --------------------
 V1.0.0����ʽ������
 ��ͼ�������������㴥��������
 ��ע��������
 POI��·������
 ������롢���������
 ��λͼ��
 --------------------
 V1.1.0��
 ���ߵ�ͼ֧��
 --------------------
 V1.1.1��
 ����suggestionSearch�ӿ�
 ���Զ�̬����annotation title
 fixС�ڴ�й¶����
 --------------------
 V1.2.1��
 ����busLineSearch�ӿ�
 �޸���λȦ��Χ�ڲ����϶���ͼ��bug
 
 V2.0.0
 
 ������
 ȫ�µ�3Dʸ����ͼ��Ⱦ
    BMKMapView�趨��ͼ��ת���ӽǶȣ�rotation��overlooking 
    BMKMapView�趨ָ������ʾλ�ã�compassPositon        
    BMKMapView�����������ڣ�viewWillAppear��viewWillDisappear
    ��ͼ��ע�ɵ㣬BMKMapViewDelegate�����ӿڻص��ӿ�onClickedMapPoi
    BMKAnnotationView����annotation�Ƿ�����3Dģʽ��enabled3D
 overlay���Ʒ�ʽ�ı䣬����opengl���ƣ�        
    BMKOverlayViewʹ��opengl��Ⱦ�ӿڣ�glRender�������ش˺���ʵ��gl����
    ����opengl�߻��ƣ�renderLinesWithPoints        
    ����opengl����ƣ�renderRegionWithPointsl 
 ȫ�µ�ʸ�����ߵ�ͼ���ݣ�        
    BMKOfflineMap�������ߵ�ͼ��start        
    BMKOfflineMap�������ߵ�ͼ��update        
    BMKOfflineMap��ͣ���ػ���£�pasue        
    ����ȵ�����б�getHotCityList        
    ���֧���������ݵĳ��У�getOfflineCityList        
    ���ݳ�������ѯ������Ϣ��searchCity  
 ���£�
 BMKMapView�����ż���zoomLevel����Ϊfloat�ͣ�ʵ���޼�����
 ���µ�ͼ����ö�٣�
 enum {   BMKMapTypeStandard  = 1,              ///< ��׼��ͼ      
          BMKMapTypeTrafficOn = 2,              ///< ʵʱ·��   
          BMKMapTypeSatellite = 4,              ///< ���ǵ�ͼ 
          BMKMapTypeTrafficAndSatellite = 8,    ///< ͬʱ��ʵʱ·�������ǵ�ͼ
 };

*********************/

/**
 *��ȡ��ǰ��ͼAPI�İ汾��
 *return  ���ص�ǰAPI�İ汾��
 */
UIKIT_STATIC_INLINE NSString* BMKGetMapApiVersion()
{
	return @"2.0.0";
}
