
<?php
$hospital = '';
if(isset(Yii::app()->session['iduser'])){

 $hospital = Yii::app()->db->createCommand()
    ->select('hopitalName')
    ->from('hospital')
    ->where('iduser=:id', array(':id'=>Yii::app()->session['iduser']))
    ->queryScalar();
}
$this->beginWidget('zii.widgets.CPortlet', array(
  'htmlOptions'=>array(
    'class'=>''
  )
));
$this->widget('bootstrap.widgets.TbMenu', array(
  'type'=>'pills',
  'items'=>array(
  array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'),'visible'=>Yii::app()->user->groupe!=1, 'linkOptions'=>array()),
  array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/admin'), 'linkOptions'=>array()),
  array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/index'),'visible'=>Yii::app()->user->groupe!=1, 'linkOptions'=>array()),
  array('label'=>'Formulaire des sois du patient', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/formulaire',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
  array('label'=>'Ordonnance Medicale', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/ordonnanceMedicale',array('id'=>$_GET['id'])), 'visible'=>Yii::app()->user->groupe!=2,'linkOptions'=>array()),
    array('label'=>'Medical spectacle prescription', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/lunette',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2,'active'=>true, 'linkOptions'=>array()),
    array('label'=>'Bullettin d\'analyse', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/analyseDemande',array('id'=>$_GET['id'])), 'visible'=>Yii::app()->user->groupe!=2,'linkOptions'=>array()),
    array('label'=>'Print', 'icon'=>'icon-print', 'url'=>'javascript:void(0);return false', 'linkOptions'=>array('onclick'=>'printDiv();return false;')),

    ),
));
$this->endWidget();


$birthday_timestamp = strtotime($data->birthday);  
// Calculates age correctly
// Just need birthday in timestamp
$age = date('md', $birthday_timestamp) > date('md') ? date('Y') - date('Y', $birthday_timestamp) - 1 : date('Y') - date('Y', $birthday_timestamp);
  ?>
</hr>
<div class='printableArea'>
<table width='80%' border=0>
  <tr>
    <th colspan="2" align=left>
      MUTUELLE DE SANTE DE L'UNR</BR>
      NUR HEALTH INSURANCE SCHEMA<BR>
      B.P: 111 HUYE
    </th>
        <th colspan="1" align=left>
    
   <h3> MS/UNR</h3>
      </th>
    <th colspan="1" align=left>
    NO <br><br>
    SOLIDALITE<br>
    EQUITE<br>
    RESPONSABILITE<br>
    </th>
  </tr>
  <tr>
    <td COLSPAN=4 align='center'><h3><u>PRESCRIPTION DE LUNETTES MEDICALES/ MEDICAL SPECTACLE PRESCRIPTION</u></h3></td>
  </tr>
  <tr>
    <td COLSPAN=2>
      Etablissement de soins/ Health Establishment :<?php echo $hospital;?></td>
    <td COLSPAN=2> N° ordonnance/Prescription NO</td>
    
  </tr>
  <tr>
    <td COLSPAN=2 rowspan=2> Identite du prescripteur / Prescriber Identity: </td>
    <td> Noms / Names : <?php echo CHtml::encode($data->firstname); ?> <?php echo CHtml::encode($data->middlename); ?> <?php echo CHtml::encode($data->lastname); ?></td>
</tr>
 <tr><td>Qualification</td></tr>
 <tr><td colspan=4>&nbsp;</td></tr>
    <tr>
    <td COLSPAN=4> Identite du patient / Patient identity :<br>
       <ul>
              <li>Noms de I'adher ent/ Names of affiliate : <?php echo CHtml::encode($data->firstname); ?> <?php echo CHtml::encode($data->middlename); ?> <?php echo CHtml::encode($data->lastname); ?></li>
              <li>N° de la carte de Paffilie / Affiliate card N° <?php echo CHtml::encode($data->cardnumber); ?></li>
              <li>Departernent affectataire / Employer</li>
              <li>Beneficiaire / Beneficiary:
                   <ul>
                      <li>Adherent lui-meme / Self: Yes</li>
                      <li>Conjoint / Partner: D Noms / Names </li>
                      <li>Enfant / Infant: D Noms / Names &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Age</li>
                   </ul>
              </li>
       </ul>
    </td>
      </tr>
     <tr>
    <td COLSPAN=4>
        <table border=1 width='100%'>
           <tr>
               <td rowspan=2 width='20%'>.</td>
                <td colspan=3>Oeil Droit /Eye Right</td>
                 <td colspan=3>Oeil Gauche / Eye Left</td>
           </tr>
            <tr>
               <td>Sphere /Spherical</td>
                <td>Cylindre/ Cylindrical</td>
                 <td>Axe(')Axis(")</td>
                 <td>Sphere /Spherical</td>
                <td>Cylindre/ Cylindrical</td>
                 <td>Axe(')Axis(")</td>
           </tr>
            <tr>
               <td colspan=1>Vision de loin! Distant vision</td>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
                 
                 
           </tr>
             <tr>
               <td colspan=1>Vision de loin! Distant vision</td>
                <td colspan=3>&nbsp;</td>
                 <td colspan=3>&nbsp;</td>
                 
           </tr>
            <tr>
               <td colspan=7>.</td>
            </tr>
              <tr>
               <td colspan=3>Distance inter pupltlaf re /Interpupillary distance</td>
               <td colspan=2>LoinlDistant (mm) :</td>
               <td colspan=2>Pres /Near (mm) :</td>
            </tr>
        </table>
    </td>
  </tr>
  <tr>
    <td COLSPAN=2> Type de verres : Mineraux / Mineral</td>
     <td COLSPAN=2> Clairs / Clears</td>
    
  </tr>
    <tr>
    <td COLSPAN=2>Type of lenses Organiques / Organic</td>
    <td COLSPAN=2> Photochromiques / Photo chromic</td>
  </tr>
   <tr><td>&nbsp;</td></tr>
   <tr>
    <td COLSPAN=3> Double foyers / Bifocal</td>
     <td > &nbsp;</td>
   </tr>
   
    <tr>
    <td COLSPAN=3 align='right'> Progressifs / Progressive</td>
     <td > &nbsp;</td>
    </tr>
     <tr><td>&nbsp;</td></tr>
     <tr>
    <td COLSPAN=3> Date, le <?php echo date('d/m/Y');?></td>
     <td > &nbsp;</td>
    </tr>
     <tr><td>&nbsp;</td></tr>
     <tr>
    <td COLSPAN=2> Signature du prescripteur</br>
                   Signature of the prescriber</td>
     <td COLSPAN=2> Signature et cachet de I'agent MS/UNR</br>
                    Signature& stamp of MS/VNR agent</td>
    </tr>
      
</table>
</div>
<style type="text/css" media="print">
body {visibility:hidden;}
.printableArea{visibility:visible;} 
</style>
<script type="text/javascript">
function printDiv()
{

window.print();

}
</script>
